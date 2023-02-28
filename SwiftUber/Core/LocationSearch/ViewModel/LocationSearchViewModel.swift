//
//  LocationSearchViewModel.swift
//  SwiftUber
//
//  Created by Sam on 26/02/2023.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    
    //MARK: - Properties
    @Published var result = [MKLocalSearchCompletion]()
    @Published var selectedUberLocation: UberLocation?
    @Published var pickUpTime: String?
    @Published var dropOffTime: String?
    
    
    
    private let searchCompleter = MKLocalSearchCompleter()
    
    var queryFragments: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragments
        }
    }
    
    var userLocation: CLLocationCoordinate2D?
    
    
    // MARK: - Init
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragments
    }
    
    //MARK: - Helpers
    
    /// Setter function to update selectedLocation
    /// - Parameter localSearch: Selected locaton
    func selectLocation(_ localSearch: MKLocalSearchCompletion) {
        locationSearch(
            forLocalSearchCompletion: localSearch) { response, error in
                if let error = error {
                    fatalError(error.localizedDescription)
                }
                
                guard let item = response?.mapItems.first else { return }
                
                let coordinates = item.placemark.coordinate
                self.selectedUberLocation = UberLocation(title: localSearch.title,
                                                         coordinate: coordinates)
            }
    }
    
    func locationSearch(forLocalSearchCompletion locationSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = locationSearch.title.appending(locationSearch.subtitle)
        
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
    
    
    func computeRidePrice(forType rideType: RideType) -> Double {
        guard let coordinate = selectedUberLocation?.coordinate else { return 0.0 }
        guard let userLocation = self.userLocation else { return 0.0 }
        
        let pickup = CLLocation(latitude: userLocation.latitude,
                                      longitude: userLocation.longitude)
        let destination = CLLocation(latitude: coordinate.latitude,
                                     longitude: coordinate.longitude)
        
        let distanceInMeters = destination.distance(from: pickup)
        
        return rideType.computePrice(for: distanceInMeters)
        
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
                print(error.localizedDescription)
                return
            }
            
            guard let route = response?.routes.first else { return }
            self.configPickupAndDropOffTimes(with: route.expectedTravelTime)
            completion(route)
        }
    }
    
    
    func configPickupAndDropOffTimes(with expectedTravelTime: Double ) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        pickUpTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date() + expectedTravelTime)
    }
    
}

// MARK: - MKLocalSearchCompleterDelegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.result = completer.results
    }
}
