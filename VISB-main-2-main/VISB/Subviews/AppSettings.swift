//
//  AppSettings.swift
//  VISB
//SENIOR PROJECT IN PROGRESS 
//  Created by Jevanie Davis on 2/18/25.
//import SwiftUI
import SwiftUI
import Combine

class AppSettings: ObservableObject {
    static let shared = AppSettings()

    // Accessibility Settings
    @Published var isEnhancedVoiceOverEnabled: Bool = true
    @Published var speechRate: Double = 1.0
    @Published var isHapticFeedbackEnabled: Bool = true
    @Published var isAudioDescriptionsEnabled: Bool = true

    // Simulated ROS Connection
    @Published var isROSConnected: Bool = true

    func publish(topic: String, message: [String: Any]) {
        // Simulate publishing to ROS
        print("Simulated publish to \(topic): \(message)")
        AlertManager.shared.notifyUser(message: "Command sent to robot.")
    }
}

#Preview {
    Text("AppSettings Preview")
        .environmentObject(AppSettings.shared)
}
