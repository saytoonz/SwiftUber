//
//  LocationSearchActivationView.swift
//  SwiftUber
//
//  Created by Sam on 26/02/2023.
//

import SwiftUI

struct LocationSearchActivationView: View {
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.theme.primaryTextColor)
                .frame(width: 8, height: 8)
                .padding(.horizontal)
            
            Text("Where to?")
                .foregroundColor(Color.theme.primaryTextColor)
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
        .background(
            Rectangle()
                .fill(Color.theme.backgroundColor)
                .shadow( radius: 6)
        )
        
    }
}

struct LocationSearchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActivationView()
    }
}
