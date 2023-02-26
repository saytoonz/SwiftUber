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
}

// MARK: - MKLocalSearchCompleterDelegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.result = completer.results
    }
}
