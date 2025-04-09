//
//  SpeechRecognizer.swift
//  Navigation_Functionality
//
//  Created by Jevanie Davis on 2/3/25.
//
import AVFoundation
import SwiftUI

class SpeechRecognizer: ObservableObject {
    private let synthesizer = AVSpeechSynthesizer()
    private var isListening = false

    func startListening(completion: @escaping (String) -> Void) {
        let fakeCommand = ["Turn left", "Turn right", "Go straight", "Stop Navigation"].randomElement()!
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(fakeCommand)
        }
    }

    func stopListening() {
        isListening = false
    }

    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
    }

    func warnOffRoute() {
        speak("You have moved off route. Recalculating...")
    }
}

