//
//  RideRequestView.swift
//  SwiftUber
//
//  Created by Sam on 27/02/2023.
//

import SwiftUI

struct RideRequestView: View {
    var body: some View {
        VStack {
            
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
            
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
                    ForEach(0 ..< 4, id: \.self) { _ in
                        VStack(alignment: .leading){
                            Image("uber-x")
                                .resizable()
                                .scaledToFit()
                            
                            VStack(spacing: 4){
                                Text("UberX")
                                    .font(.system(size: 14, weight: .semibold ))
                                
                                Text("₵22.0")
                                    .font(.system(size: 14, weight: .semibold ))
                            }
                            .padding(8)

                        }
                        .frame(width: 112, height: 140)
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(10)
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
        .background(.white)
        
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
