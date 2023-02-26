//
//  UberMapViewRepresentable.swift
//  SwiftUber
//
//  Created by Sam on 26/02/2023.
//

import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
    
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
        if let coordinate = locationSearchVM.selectedLocationCoordinate {
//            print("DEBUG: UberMapViewRepresentable->updateUIView-> selectedLoctaoin \(coordinate)")
            context.coordinator.addAndSelectAnnotation(withCoodinate: coordinate)
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
            
            parent.mapView.setRegion(region, animated: true)
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
    }
    
}
