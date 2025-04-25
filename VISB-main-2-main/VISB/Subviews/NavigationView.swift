//
//  NavigationView.swift
//  VISB
//
//  Created by violetedwards on 1/30/25.
//import SwiftUI
import SwiftUI
import MapKit
import AVFoundation

struct NavigationView: View {
    @EnvironmentObject var appSettings: AppSettings
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 38.92153265231176, longitude: -77.02107302194575),
        span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
    )
    @State private var annotations: [IdentifiableAnnotation] = []
    @State private var instructions: String = ""
    @State private var isFetchingData: Bool = false
    @State private var currentStep: Int = 0
    @State private var routeSteps: [[String: Any]] = []
    @State private var isNavigating: Bool = false
    @State private var timer: Timer?
    @State private var selectedDestination: String = "Smart Room 2006" // Hardcoded destination
    @State private var selectedStartLocation: String = "Reading Room" // Hardcoded start location
    @State private var commuteTime: String = ""
    @State private var walkingImage: String = "figure.walk"
    @State private var walkingDirection: String = "arrow.up"
    @State private var currentLocation: CLLocationCoordinate2D?
    @State private var heading: Double = 0
    @State private var isDataLoaded: Bool = false

    struct IdentifiableAnnotation: Identifiable {
        let id = UUID()
        var coordinate: CLLocationCoordinate2D
    }

    let destinations = ["Reading Room", "Howard Hospital", "Howard Law School", "Howard Chapel", "Howard Engineering Building", "Smart Room 2006"]
    let startLocations = ["Smart Room 2006", "LKD", "Reading Room"]

    var body: some View {
        VStack {
            MapView(region: $region, annotations: annotations, currentLocation: $currentLocation, heading: $heading)
                .ignoresSafeArea()
                .frame(height: 300)

            if isNavigating {
                VStack {
                    Image(systemName: walkingImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50) // Reduced size
                        .foregroundColor(.blue)
                        .rotationEffect(.degrees(heading))
                        .padding(.top, 5)

                    Image(systemName: walkingDirection)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35) // Reduced size
                        .foregroundColor(.green)
                        .padding(.top, 5)

                    Text(instructions)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding()

                    Text("Estimated Commute Time: \(commuteTime)")
                        .font(.subheadline)
                        .padding(.bottom, 5)
                }
                .frame(maxHeight: 180) // Adjusted to prevent pushing button
            } else if isFetchingData {
                ProgressView("Fetching navigation data...")
                    .padding()
            } else if isDataLoaded {
                VStack {
                    Text("Navigation Data Loaded")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Text("Ready to Go!")
                        .font(.title2)
                        .foregroundColor(.green)
                        .padding()
                    ScrollView {
                        Text(instructions)
                            .font(.body)
                            .padding()
                    }
                    .frame(height: 80)
                }
            }

            // Removed Pickers as the start and destination are hardcoded
            // Picker("Select Start Location", selection: $selectedStartLocation) {
            //     ForEach(startLocations, id: \ .self) { location in
            //         Text(location).tag(location)
            //     }
            // }
            // .pickerStyle(MenuPickerStyle())
            // .padding()
            Text("Starting from: \(selectedStartLocation)")
                .padding(.top)

            // Picker("Select Destination", selection: $selectedDestination) {
            //     ForEach(destinations, id: \ .self) { destination in
            //         Text(destination).tag(destination)
            //     }
            // }
            // .pickerStyle(MenuPickerStyle())
            // .padding()
            Text("Going to: \(selectedDestination)")
                .padding(.bottom)

            Button(action: startNavigation) {
                Text(isNavigating ? "Stop Navigation" : "Start Navigation from \(selectedStartLocation) to \(selectedDestination)")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isNavigating ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .padding()
        }
        .onAppear { fetchNavigationData() }
        .onDisappear { stopNavigation() }
        // Removed onChange modifiers as the start and destination are hardcoded
        // .onChange(of: selectedDestination) { _, _ in fetchNavigationData() }
        // .onChange(of: selectedStartLocation) { _, _ in fetchNavigationData() }
    }

    private func fetchNavigationData() {
        isFetchingData = true
        NavigationManager.shared.fetchNavigationData(start: selectedStartLocation, destination: selectedDestination) { data in
            if let route = data["route"] as? [[String: Any]] {
                self.routeSteps = route
                self.instructions = NavigationManager.shared.convertToGoogleMapsInstructions(data: data)
            }
            if let waypoints = data["waypoints"] as? [[String: Double]] {
                for waypoint in waypoints {
                    if let latitude = waypoint["latitude"], let longitude = waypoint["longitude"] {
                        annotations.append(IdentifiableAnnotation(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)))
                    }
                }
            }
            if let time = data["commute_time"] as? String {
                self.commuteTime = time
            }
            isFetchingData = false
            isDataLoaded = true
        }
    }

    private func startNavigation() {
        if isNavigating {
            stopNavigation()
            return
        }
        isNavigating = true
        currentStep = 0
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            if currentStep < routeSteps.count {
                announceStep(routeSteps[currentStep])
                updateWalkingImageAndDirection(routeSteps[currentStep])
                currentStep += 1
            } else {
                stopNavigation()
            }
        }
    }

    private func stopNavigation() {
        timer?.invalidate()
        timer = nil
        isNavigating = false
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short

            let newTrip = Trip(
            id: UUID().hashValue,
            name: selectedDestination,
            date: dateFormatter.string(from: Date()),
            address: selectedDestination,
            description: "Trip from \(selectedStartLocation) to \(selectedDestination)",
            imageName: "placeholder"
        )

        appSettings.tripHistory.append(newTrip)
    }

    private func announceStep(_ step: [String: Any]) {
        if let instruction = step["instruction"] as? String {
            SpeechManager.shared.speak(instruction)
        }
    }

    private func updateWalkingImageAndDirection(_ step: [String: Any]) {
        if let action = step["action"] as? String {
            switch action {
            case "start": walkingDirection = "arrow.up"
            case "turn_left": walkingDirection = "arrow.turn.up.left"
            case "turn_right": walkingDirection = "arrow.turn.up.right"
            case "arrive": walkingDirection = "arrow.up"
            default: walkingDirection = "arrow.up"
            }
        }
    }
}

#Preview {
    NavigationView()
        .environmentObject(AppSettings.shared)
}
