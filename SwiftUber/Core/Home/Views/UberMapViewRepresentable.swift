//
//  UberMapViewRepresentable.swift
//  SwiftUber
//
//  Created by Sam on 26/02/2023.
//

import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
    
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationSearchVM: LocationSearchViewModel
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    
    //This is where the view to be represented in UIView is created
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    /// Use this function to update mapView
    /// - Some updates:
    ///   - 1:  Display polylines
    ///   - 2: etc
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
            break
        case .searchingForLocation:
            break
        case .locationSelected:
                //  print("UberMapViewRepresentable->updateUIView->selectedLoctaoin:  Map state is\(mapState)")
            if let coordinate = locationSearchVM.selectedLocationCoordinate {
                //  print("DEBUG: UberMapViewRepresentable->updateUIView-> selectedLoctaoin \(coordinate)")
                context.coordinator.addAndSelectAnnotation(withCoodinate: coordinate)
                context.coordinator.configurePolylines(withDestinationCoordinate: coordinate  )
            }
            break
        }
    }
    
    func makeCoordinator() -> MapCodinator {
        return MapCodinator(parent: self)
    }
}




extension UberMapViewRepresentable {
    
    class MapCodinator: NSObject, MKMapViewDelegate {
        // MARK: - Properties
        let parent: UberMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentMapViewRegion: MKCoordinateRegion?
        
        // MARK: - Init
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        
        
        // MARK: - MKMapView Delegate
        /// This delegate method tell if the user location is updated
        /// In here, we will use the userLocation parameter to create a boundrary/Region to zoom in
        /// And display the user location
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            userLocationCoordinate = userLocation.coordinate
            
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: userLocation.coordinate.latitude,
                    longitude: userLocation.coordinate.longitude
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.05,
                    longitudeDelta: 0.05
                )
            )
            currentMapViewRegion = region
            
            parent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            
            return polyline
        }
        
        
        // MARK: - Helpers
        
        // Add Annotation / Marker to mapview
        func addAndSelectAnnotation(withCoodinate coodinate: CLLocationCoordinate2D) {
            
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coodinate
            parent.mapView.addAnnotation(annotation)
            parent.mapView.selectAnnotation(annotation, animated: true)
            
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        
        func configurePolylines(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            guard let userLocCoordinate = userLocationCoordinate else { return }
            getDestinationRoute(from: userLocCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
            }
        }
        
        
        func getDestinationRoute(
            from userLocation: CLLocationCoordinate2D,
            to destination: CLLocationCoordinate2D,
            completion: @escaping (MKRoute) -> Void
        ) {
            let userPlacemark = MKPlacemark(coordinate: userLocation)
            let destPlacemark = MKPlacemark(coordinate: destination)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: destPlacemark)
            
            let directions = MKDirections(request: request)
            directions.calculate { response, error in
                if let error = error {
                    print("DEBUG: UberMapViewRepresentable->getDestinationRoute->directions.calculate \(error.localizedDescription)")
                    return
                }
                
                guard let route = response?.routes.first else { return }
                
                completion(route)
            }
        }
        
        
        func clearMapViewAndRecenterOnUserLocation() {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            if let currentMapViewRegion = currentMapViewRegion {
                parent.mapView.setRegion(currentMapViewRegion, animated: true)
            }
        }
    }
    
}
