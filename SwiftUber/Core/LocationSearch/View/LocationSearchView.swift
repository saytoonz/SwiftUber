//
//  LocationSearchView.swift
//  SwiftUber
//
//  Created by Sam on 26/02/2023.
//

import SwiftUI

struct LocationSearchView: View {
    @State private var startLocationText = ""
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationSearchVM: LocationSearchViewModel
    
    var body: some View {
        VStack{
            //MARK: - Header View
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    
                    Rectangle()
                        .fill(Color(.black))
                        .frame(width: 6, height: 6)
                }
                VStack {
                    TextField("Current Location", text: $startLocationText)
                        .frame(height: 32)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                    
                    TextField("Where to?", text: $locationSearchVM.queryFragments)
                        .frame(height: 32)
                        .background(Color(.systemGray5))
                        .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top, 64)
            
            Divider()
                .padding(.vertical)
            
            //MARK: - List View
            ScrollView {
                VStack (alignment: .leading){
                    ForEach(locationSearchVM.result, id: \.self) { result in
                        LocationSearchResultCell(
                            title: result.title,
                            subTitle: result.subtitle
                        )
                        .onTapGesture {
                            withAnimation(.spring()){
                                locationSearchVM.selectLocation(result)
                                mapState = .locationSelected
                                
                            }
                        }
                    }
                }
            }
            
            
        }
        .background(Color(.systemBackground))
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(mapState: .constant(.searchingForLocation))
    }
}
