//
//  PlaceInfoView.swift
//  VISB
//
//  Created by Jevanie Davis on 2/17/25.
//
import SwiftUI

struct PlaceInfoView: View {
    @EnvironmentObject var appSettings: AppSettings
    var trip: Trip

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Trip Image (with accessibility label)
                Image(trip.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(12)
                    .accessibilityLabel("Image of \(trip.name)")
                
                // Trip Name (Large Font)
                Text(trip.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                // Trip Address (Medium Font)
                Text(trip.address)
                    .font(.title3)
                    .foregroundColor(.secondary)
                
                // Trip Description (Small Font)
                Text(trip.description)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineLimit(nil) // Allow full description to be visible
            }
            .padding(.horizontal)
        }
        .navigationTitle(trip.name)
        .background(Color(.systemBackground)) // High-contrast background
    }
}

#Preview {
    PlaceInfoView(trip: Trip(id: 0, name: "Howard Plaza Towers", date: "2/1/25", address: "2225 Georgia Ave NW, Washington, DC 20059", description: "A residential building for Howard University students, offering a variety of amenities including study rooms, a fitness center, and a convenience store.", imageName: "hpt"))
        .environmentObject(AppSettings.shared)
}
