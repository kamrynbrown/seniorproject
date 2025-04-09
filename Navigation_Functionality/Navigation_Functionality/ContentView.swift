//
//  ContentView.swift
//  Navigation_Functionality
//
//  Created by Jevanie Davis on 2/3/25.
//
import SwiftUI
import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @State private var navigationPath: String?
    @State private var isListening = false

    var body: some View {
        VStack {
            Text("Welcome to AccessibleNavApp")
                .font(.largeTitle)
                .bold()
                .padding()

            Text("Say 'Home', 'Trips', 'Emergency', or 'Start Navigation'")
                .padding()

            Button(isListening ? "Stop Listening" : "Start Listening") {
                toggleListening()
            }
            .padding()
            .background(isListening ? Color.red : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            if let command = navigationPath {
                Text("Recognized Command: \(command.capitalized)")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .onChange(of: navigationPath) { _, newCommand in
            if let command = newCommand {
                handleVoiceCommand(command)
            }
        }
    }

    private func toggleListening() {
        if isListening {
            speechRecognizer.stopListening()
        } else {
            speechRecognizer.startListening { command in
                navigationPath = command
            }
        }
        isListening.toggle()
    }

    private func handleVoiceCommand(_ command: String) {
        switch command.lowercased() {
        case "home":
            NavigationManager.shared.navigate(to: HomeView())
        case "trips":
            NavigationManager.shared.navigate(to: TripsView())
        case "emergency":
            NavigationManager.shared.navigate(to: EmergencyView())
        case "start navigation":
            NavigationManager.shared.navigate(to: HomeView())
        default:
            speechRecognizer.speak("Command not recognized.")
        }
    }
}

