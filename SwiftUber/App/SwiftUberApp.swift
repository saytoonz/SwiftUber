//
//  SwiftUberApp.swift
//  SwiftUber
//
//  Created by Sam on 26/02/2023.
//

import SwiftUI

@main
struct SwiftUberApp: App {
    @StateObject var locationSearchVM = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationSearchVM)
        }
    }
}
