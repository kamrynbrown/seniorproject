//
//  ContentView.swift
//  VISB
//
//  Created by violetedwards on 1/30/25.
// WORKING FILE
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appSettings: AppSettings
    @State var heightRatio: CGFloat = UIScreen.main.bounds.height / 2

    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundStyle(.blue)
                    .frame(maxHeight: heightRatio)

                HStack {
                    Image("Robot")
                        .resizable()
                        .frame(width: 204, height: 374.25)
                        .accessibilityLabel("Picture of robot")
                    Spacer().frame(width: 50)
                    Text("100%")
                        .foregroundColor(.white)
                }
                .padding(.trailing)
            }

            VStack(spacing: 16) {
                NavigationLink(destination: NavigationView()) {
                    Text("Start Navigation")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .padding(.horizontal)
                .onTapGesture {
                    if appSettings.isHapticFeedbackEnabled {
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    }
                    SpeechManager.shared.speak("Starting navigation")
                }

                NavigationLink(destination: HistoryView()) {
                    Text("Trips History")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .padding(.horizontal)
                .onTapGesture {
                    if appSettings.isHapticFeedbackEnabled {
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    }
                    SpeechManager.shared.speak("Viewing trips history")
                }

                NavigationLink(destination: EmergencyView()) {
                    Text("Emergency")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .padding(.horizontal)
                .onTapGesture {
                    if appSettings.isHapticFeedbackEnabled {
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    }
                    SpeechManager.shared.speak("Emergency options")
                }

                NavigationLink(destination: SettingsView()) {
                    Text("Settings")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .padding(.horizontal)
                .onTapGesture {
                    if appSettings.isHapticFeedbackEnabled {
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    }
                    SpeechManager.shared.speak("Opening settings")
                }
            }
            .padding(.top, 20)
            Spacer()
        }
        .onAppear {
            SpeechManager.shared.speak("Welcome to the main screen. You can start navigation, view trips history, access emergency options, or open settings.")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppSettings.shared)
}
