//
//  TripsView.swift
//  Navigation_Functionality
//
//  Created by Jevanie Davis on 2/3/25.
//
import SwiftUI

struct TripsView: View {
    let trips = ["Trip One: New York", "Trip Two: Philadelphia", "Trip Three: DC"]
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @State private var selectedTrip: String?

    var body: some View {
        VStack {
            Text("Trip History")
                .font(.largeTitle)
                .bold()
                .padding()

            ForEach(trips, id: \.self) { trip in
                Text(trip)
                    .padding()
                    .onTapGesture {
                        selectedTrip = trip
                        speechRecognizer.speak("Selected \(trip). Say 'Navigate to this location' to start.")
                    }
            }

            if let selectedTrip = selectedTrip {
                Text("Selected Trip: \(selectedTrip)")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.gray)
            }
        }
        .onChange(of: selectedTrip) { oldTrip, newTrip in
            if let trip = newTrip {
                startNavigation(trip)
            }
        }
    }

    private func startNavigation(_ destination: String) {
        speechRecognizer.speak("Navigating to \(destination)")
    }
}

struct TripsView_Previews: PreviewProvider {
    static var previews: some View {
        TripsView()
            .previewDevice("iPhone 14")
    }
}
