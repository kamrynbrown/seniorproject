//
//  AlertManager.swift
//  VISB
//
//  Created by Jevanie Davis on 3/17/25.
//


import AVFoundation
import UIKit

class AlertManager {
    static let shared = AlertManager()
    private let speechManager = SpeechManager.shared

    func notifyUser(message: String, withHaptic: Bool = true) {
        // Speak the message
        speechManager.speak(message)

        // Provide haptic feedback
        if withHaptic {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
    }
}