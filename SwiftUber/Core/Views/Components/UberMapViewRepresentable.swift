//
//  UberMapViewRepresentable.swift
//  SwiftUber
//
//  Created by Sam on 26/02/2023.
//

import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    
    //This is where the view to be represented in UIView is created
    func makeUIView(context: Context) -> some UIView {
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
        
    }
    
    func makeCoordinator() -> MapCodinator {
        return MapCodinator(parent: self)
    }
}

extension UberMapViewRepresentable {
    
    class MapCodinator: NSObject, MKMapViewDelegate {
        let parent: UberMapViewRepresentable
        
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
    }
    
}
