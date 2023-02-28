//
//  RideRequestView.swift
//  SwiftUber
//
//  Created by Sam on 27/02/2023.
//

import SwiftUI

struct RideRequestView: View {
    
    @State private var selectedRideType: RideType = .uberX
    @EnvironmentObject var locationSearchVM: LocationSearchViewModel
    
    
    var body: some View {
        VStack {
            
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            
//        MARK: - Trip info view
            
            HStack  {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8, height: 8)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    
                    Rectangle()
                        .fill(Color(.black))
                        .frame(width: 8, height: 8)
                }
                
                VStack {
                    HStack {
                        Text("Current Location")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Text("1:30 PM")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        Text("Destination Location")
                            .font(.system(size: 16, weight: .semibold))
                            
                        
                        Spacer()
                        
                        Text("1:45 PM")
                            .font(.system(size: 14, weight: .semibold ))
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 10)
                    
                }
                .padding(.leading, 8)
            }
            .padding()
            
            Divider()
            
            // MARK: - Ride type selection View
            
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold )
                .padding()
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(RideType.allCases) { rideType in
                        VStack(alignment: .leading){
                            Image(rideType.imageName)
                                .resizable()
                                .scaledToFit()
                            
                            VStack(alignment: .leading,  spacing: 4){
                                Text(rideType.description )
                                    .font(.system(size: 14, weight: .semibold ))
                                
                                Text(locationSearchVM.computeRidePrice(forType: rideType).toCurrency())
                                    .font(.system(size: 14, weight: .semibold ))
                            }
                            .padding()

                        }
                        .frame(width: 112, height: 140)
                        .foregroundColor(rideType == selectedRideType ? .white : .black)
                        .background(Color(rideType == selectedRideType ? .systemBlue :.systemGroupedBackground))
                        .scaleEffect(rideType == selectedRideType ? 1.2 : 1.0)
                        .cornerRadius(10)
                        .onTapGesture {
                            withAnimation(.spring()){
                                selectedRideType = rideType
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            Divider()
                .padding(.vertical, 8)
            
            // MARK: - Payment option view
            
            HStack(spacing: 12) {
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(4)
                    .foregroundColor(.white)
                    .padding(.leading)
                
                Text("**** 1234")
                    .fontWeight(.bold)
                
                Spacer()
                
                 Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
                
            }
            .frame(height: 50)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(10)
            .padding(.horizontal)
            
            
            // MARK: - Request Ride Button
            
            Button {
                
            } label: {
                Text("CONFIRM RIDE")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                
            }
            
        }
        .padding(.bottom, 24)
        .background(.white)
        .cornerRadius(16)
        
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
