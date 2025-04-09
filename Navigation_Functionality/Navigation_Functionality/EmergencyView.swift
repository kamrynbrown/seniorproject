//
//  EmergencyView.swift
//  Navigation_Functionality
//
//  Created by Jevanie Davis on 2/3/25.
//
import SwiftUI
import AVFoundation

struct EmergencyView: View {
    @StateObject private var speechRecognizer = SpeechRecognizer()

    var body: some View {
        VStack {
            Text("Emergency Settings")
                .font(.largeTitle)
                .bold()
                .padding()

            Text("Say 'Call 911', 'Emergency Contact', or 'Return to Home'.")
                .padding()

            Button("Start Listening") {
                speechRecognizer.startListening { command in
                    handleEmergencyCommand(command)
                }
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }

    private func handleEmergencyCommand(_ command: String) {
        switch command.lowercased() {
        case "call 911":
            speechRecognizer.speak("Calling 911. Are you sure?")
        case "emergency contact":
            speechRecognizer.speak("Calling emergency contact.")
        case "return to home":
            NavigationManager.shared.navigate(to: HomeView())
        default:
            speechRecognizer.speak("Command not recognized.")
        }
    }
}
