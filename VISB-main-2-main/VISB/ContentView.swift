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

                NavigationLink(destination: HistoryView(trips: [
                    Trip(id: 0, name: "Howard Plaza Towers", date: "2/1/25", address: "2225 Georgia Ave NW, Washington, DC 20059", description: "A residential building for Howard University students, offering a variety of amenities including study rooms, a fitness center, and a convenience store.", imageName: "hpt"),
                    Trip(id: 1, name: "LKD Library", date: "2/1/25", address: "500 Howard Pl NW, Washington, DC 20059", description: "The Founders Library is a historic building on the campus of Howard University. It serves as a central hub for students to study and access academic resources.", imageName: "lkd"),
                    Trip(id: 2, name: "Undergraduate Library", date: "2/3/25", address: "500 Howard Pl NW, Washington, DC 20059", description: "The Undergraduate Library at Howard University provides a quiet space for students to study, with access to computers, printers, and a wide range of books.", imageName: "ugl"),
                    Trip(id: 3, name: "CVS", date: "2/3/25", address: "2301 Georgia Ave NW, Washington, DC 20001", description: "A convenient pharmacy and retail store offering a wide range of products including medications, health products, and groceries.", imageName: "cvs"),
                    Trip(id: 4, name: "McDonald's", date: "2/5/25", address: "2400 Georgia Ave NW, Washington, DC 20001", description: "A popular fast-food restaurant offering burgers, fries, and other quick meals. It's a favorite spot for students looking for a quick bite.", imageName: "mcdonalds"),
                    Trip(id: 5, name: "Howard University Hospital", date: "2/7/25", address: "2041 Georgia Ave NW, Washington, DC 20060", description: "The Howard University Hospital provides comprehensive healthcare services to the community, including emergency care, specialized treatments, and wellness programs.", imageName: "huh")
                ])) {
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
