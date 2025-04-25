//
//  EmergencyView.swift
//  VISB
//
//  Created by violetedwards on 1/30/25.
//import SwiftUI
import SwiftUI

struct EmergencyView: View {
    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Emergency Icon with High Contrast
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.yellow)
                    .accessibilityLabel("Emergency icon")
                    .accessibilityHint("This icon indicates that you are on the emergency options screen.")

                // Title with Large Font
                Text("Emergency Options")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                    .accessibilityAddTraits(.isHeader)
                    .accessibilityHint("This is the title of the emergency options screen.")

                // Buttons with Large Touch Targets
                VStack(spacing: 20) {
                    // Call 911 Button
                    EmergencyButton(
                        icon: "phone.fill",
                        label: "Call 911",
                        color: .red,
                        action: { open(link: "tel://911") },
                        accessibilityHint: "Double tap to call emergency services."
                    )

                    // Emergency Contact Button
                    EmergencyButton(
                        icon: "phone.fill",
                        label: "Call Emergency Contact",
                        color: .blue,
                        action: { open(link: "tel://18882804331") },
                        accessibilityHint: "Double tap to call your emergency contact."
                    )

                    // Reset Robot Button
                    EmergencyButton(
                        icon: "arrow.clockwise",
                        label: "Reset Robot",
                        color: .green,
                        action: {
                            appSettings.publish(topic: "/reset", message: ["data": "reset"])
                            SpeechManager.shared.speak("Resetting TurtleBot 4.")
                        },
                        accessibilityHint: "Double tap to reset the robot."
                    )

                    // Report to Amazon Button
                    EmergencyButton(
                        icon: "envelope.fill",
                        label: "Report to Amazon",
                        color: .orange,
                        action: { open(link: "https://www.amazon.com/gp/help/customer/contact-us") },
                        accessibilityHint: "Double tap to report an issue to Amazon."
                    )
                }
                .padding(.horizontal, 20)

                Spacer()
            }
            .padding(.vertical, 40)
        }
        .navigationTitle("Emergency")
        .background(Color(.systemBackground))
        .onAppear {
            // Provide an auditory overview of the screen
            SpeechManager.shared.speak("Emergency options screen. You can call 911, call an emergency contact, reset the robot, or report to Amazon.")
        }
    }

    private func open(link: String) {
        if let url = URL(string: link), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("Error opening this link")
        }
    }
}

// Reusable Emergency Button Component
struct EmergencyButton: View {
    var icon: String
    var label: String
    var color: Color
    var action: () -> Void
    var accessibilityHint: String

    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                Text(label)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: color.opacity(0.3), radius: 5, x: 0, y: 5)
        }
        .accessibilityLabel(label)
        .accessibilityHint(accessibilityHint)
        .onTapGesture {
            if appSettings.isHapticFeedbackEnabled {
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
            }
            SpeechManager.shared.speak("Activating \(label)")
        }
    }
}

#Preview {
    EmergencyView()
        .environmentObject(AppSettings.shared)
}
