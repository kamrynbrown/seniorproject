//
//  VISBApp.swift
//  VISB
//
//  Created by violetedwards on 1/30/25.
//
import SwiftUI

@main
struct VISBApp: App {
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(AppSettings.shared)
        }
    }
}
