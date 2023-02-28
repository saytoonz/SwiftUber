//
//  HomeView.swift
//  SwiftUber
//
//  Created by Sam on 26/02/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapViewState = MapViewState.noInput
    @EnvironmentObject var locationSearchVM: LocationSearchViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            //MARK: - Map and Search components
            ZStack(alignment: .top) {
                UberMapViewRepresentable(mapState: $mapViewState)
                    .ignoresSafeArea()
                
                if mapViewState == .searchingForLocation {
                    LocationSearchView(
                        mapState: $mapViewState
                    )
                }else if mapViewState == .noInput {
                    LocationSearchActivationView()
                        .padding(.top, 72)
                        .onTapGesture {
                            withAnimation(.spring()){
                                mapViewState = .searchingForLocation
                            }
                        }
                }
                
                MapViewActionButton(
                    mapState: $mapViewState
                )
                .padding(.leading)
                .padding(.top, 4)
            }
            
            
            // MARK: - Ride request Veiw
            if mapViewState == .locationSelected {
                RideRequestView()
                .transition(.move(edge: .bottom))
                
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location = location {
                locationSearchVM.userLocation = location
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
