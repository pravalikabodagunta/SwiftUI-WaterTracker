//
//  WaterTrackerApp.swift
//  WaterTracker
//
//  Created by Pravalika Bodagunta on 29/05/26.
//

import SwiftUI

@main
struct WaterTrackerApp: App {
    @StateObject private var waterViewModel = WaterViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(waterViewModel)
        }
    }
}
