//
//  SplashScreenView.swift
//  VISB
//
//  Created by Jevanie Davis on 2/17/25.
//
import SwiftUI
import AVFoundation

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var audioPlayer: AVAudioPlayer?

    var body: some View {
        VStack {
            if isActive {
                ContentView()
            } else {
                VStack {
                    Text("Welcome to VISB")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black) // High-contrast background
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .accessibilityLabel("Welcome to V I S B") // For VoiceOver
                    
                    Text("Your Navigation Assistant")
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.top, 10)
                        .accessibilityLabel("Your Navigation Assistant") // For VoiceOver
                }
                .padding()
                .background(Color.blue.opacity(0.9)) // High-contrast background
                .cornerRadius(25)
                .shadow(radius: 10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue.opacity(0.5)) // Soft background color
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            // Play audio when the splash screen appears
            playAudio()
            
            // Transition to the main content after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }

    // Function to play audio
    private func playAudio() {
        if let path = Bundle.main.path(forResource: "welcome_audio", ofType: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        } else {
            print("Audio file not found")
        }
    }
}

#Preview {
    SplashScreenView()
}
