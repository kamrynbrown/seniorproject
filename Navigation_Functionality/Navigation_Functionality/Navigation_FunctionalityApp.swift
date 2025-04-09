//
//  Navigation_FunctionalityApp.swift
//  Navigation_Functionality
//
//  Created by Jevanie Davis on 2/3/25.
//
import SwiftUI

@main
struct Navigation_FunctionalityApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    LocationManager.shared.requestPermission()  // Ensure correct reference
                }
        }
    }
}
