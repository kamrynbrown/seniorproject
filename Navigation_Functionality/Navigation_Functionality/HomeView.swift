//
//  HomeView.swift
//  Navigation_Functionality
//
//  Created by Jevanie Davis on 2/3/25.
//
import SwiftUI
import AVFoundation
import MapKit

struct HomeView: View {
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @ObservedObject private var locationManager = LocationManager.shared
    @State private var navigationPath: String?
    @State private var directions: [MKRoute.Step] = []
    @State private var currentStepIndex = 0

    var body: some View {
        VStack {
            Text("Live Navigation")
                .font(.largeTitle)
                .bold()
                .padding()

            Text("Say 'Start Navigation' to begin or 'Stop Navigation' to exit.")
                .padding()

            Button("Start Listening") {
                speechRecognizer.startListening { command in
                    navigationPath = command
                }
            }
            .padding()
            .background(Color.green)
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
            if let command = newCommand, command.lowercased() == "start navigation" {
                startNavigation()
            }
        }
    }

    private func startNavigation() {
        guard let userLocation = locationManager.userLocation else {
            speechRecognizer.speak("Location not found. Please try again.")
            return
        }

        speechRecognizer.speak("Please say your destination.")
        speechRecognizer.startListening { destination in
            speechRecognizer.speak("Navigating to \(destination). Fetching live directions.")
            fetchDirections(from: userLocation, to: destination)
        }
    }

    private func fetchDirections(from start: CLLocationCoordinate2D, to destination: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = destination
        request.region = MKCoordinateRegion(center: start, latitudinalMeters: 10000, longitudinalMeters: 10000)

        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let place = response?.mapItems.first else {
                speechRecognizer.speak("Destination not found.")
                return
            }
            self.getDirections(from: start, to: place.placemark.coordinate)
        }
    }

    private func getDirections(from start: CLLocationCoordinate2D, to end: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        request.transportType = .walking

        let directions = MKDirections(request: request)
        directions.calculate { response, _ in
            guard let route = response?.routes.first else {
                speechRecognizer.speak("Could not retrieve directions.")
                return
            }
            self.directions = route.steps
            currentStepIndex = 0
            startLiveGuidance()
        }
    }

    private func startLiveGuidance() {
        if directions.isEmpty {
            speechRecognizer.speak("No directions found.")
            return
        }

        speakCurrentStep()
    }

    private func speakCurrentStep() {
        if currentStepIndex < directions.count {
            let step = directions[currentStepIndex]
            speechRecognizer.speak(step.instructions)

            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.currentStepIndex += 1
                self.speakCurrentStep()
            }
        } else {
            speechRecognizer.speak("You have arrived at your destination.")
        }
    }
}
