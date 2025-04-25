//
//  SettingsView.swift
//  VISB
//
//  Created by Jevanie Davis on 2/17/25.
//
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appSettings: AppSettings
    @State private var feedbackText: String = ""

    var body: some View {
        Form {
            Section(header: Text("Accessibility for Visually Impaired Users")) {
                Toggle("Enhanced VoiceOver Descriptions", isOn: $appSettings.isEnhancedVoiceOverEnabled)
                    .accessibilityLabel("Enable enhanced VoiceOver descriptions")

                Stepper(value: $appSettings.speechRate, in: 0.5...2.0, step: 0.1) {
                    Text("Speech Rate: \(String(format: "%.1f", appSettings.speechRate))")
                }
                .accessibilityLabel("Adjust speech rate")

                Toggle("Haptic Feedback", isOn: $appSettings.isHapticFeedbackEnabled)
                    .accessibilityLabel("Enable haptic feedback")

                Toggle("Audio Descriptions", isOn: $appSettings.isAudioDescriptionsEnabled)
                    .accessibilityLabel("Enable audio descriptions")
            }

            Section(header: Text("Feedback & Support")) {
                TextField("Enter your feedback", text: $feedbackText, axis: .vertical)
                    .lineLimit(5, reservesSpace: true)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 8)
                    .accessibilityLabel("Enter your feedback")

                Button(action: submitFeedback) {
                    Text("Submit Feedback")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .buttonStyle(.borderedProminent)
                .disabled(feedbackText.isEmpty)
                .accessibilityLabel("Submit feedback")
            }
        }
        .navigationTitle("Settings")
        .onAppear {
            SpeechManager.shared.speak("You are now in the settings screen. Adjust accessibility options like enhanced VoiceOver descriptions, speech rate, haptic feedback, and audio descriptions.")
        }
    }

    private func submitFeedback() {
        print("Feedback submitted: \(feedbackText)")
        feedbackText = ""
        SpeechManager.shared.speak("Thank you for your feedback.")
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppSettings.shared)
}
