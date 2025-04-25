//
//  HistoryView.swift
//  VISB
//
//  Created by violetedwards on 1/30/25.
//
import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        List {
            ForEach(appSettings.tripHistory) { trip in
                NavigationLink(destination: PlaceInfoView(trip: trip)) {
                    VStack(alignment: .leading, spacing: 8) {
                        // Trip Name (Large Font)
                        Text(trip.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        // Trip Date (Medium Font)
                        Text(trip.date)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        // Trip Address (Medium Font)
                        Text(trip.address)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        
                        // Short Description (Small Font)
                        Text(trip.description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(2) // Limit to 2 lines for brevity
                    }
                    .padding(.vertical, 10) // Add padding for larger tap targets
                    .accessibilityElement(children: .combine) // Combine elements for VoiceOver
                    .accessibilityLabel("\(trip.name), \(trip.date), \(trip.address), \(trip.description)")
                }
            }
        }
        .navigationTitle("History")
        .background(Color(.systemBackground)) // High-contrast background
    }
}

struct Trip: Identifiable {
    var id: Int
    var name: String
    var date: String
    var address: String
    var description: String
    var imageName: String
}

#Preview {
    HistoryView()
    .environmentObject(AppSettings.shared)
}
