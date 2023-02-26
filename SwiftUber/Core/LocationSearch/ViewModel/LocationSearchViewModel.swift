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
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D?
    
    private let searchCompleter = MKLocalSearchCompleter()
    
    var queryFragments: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragments
        }
    }
    
    
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
                    print("LocationSearchViewModel->selectLocation->locationSearch \(error.localizedDescription)")
                    return
                }
                
                guard let item = response?.mapItems.first else { return }
                
                let coordinates = item.placemark.coordinate
                self.selectedLocationCoordinate = coordinates
            }
    }
    
    func locationSearch(forLocalSearchCompletion locationSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = locationSearch.title.appending(locationSearch.subtitle)
        
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
    
}

// MARK: - MKLocalSearchCompleterDelegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.result = completer.results
    }
}
