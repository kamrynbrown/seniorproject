//
//  NavigationManager.swift
//  Navigation_Functionality
//
//  Created by Jevanie Davis on 2/3/25.
//
import SwiftUI

class NavigationManager {
    static let shared = NavigationManager()

    func navigate<T: View>(to view: T) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else { return }
        
        window.rootViewController = UIHostingController(rootView: view)
        window.makeKeyAndVisible()
    }
}
