//
//  HistoryView.swift
//  VISB
//
//  Created by violetedwards on 1/30/25.
//
import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var appSettings: AppSettings
    var trips: [Trip]

    var body: some View {
        List {
            ForEach(trips) { trip in
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
    HistoryView(trips: [
        Trip(id: 0, name: "Howard Plaza Towers", date: "2/1/25", address: "2225 Georgia Ave NW, Washington, DC 20059", description: "A residential building for Howard University students, offering a variety of amenities including study rooms, a fitness center, and a convenience store.", imageName: "hpt"),
        Trip(id: 1, name: "LKD Library", date: "2/1/25", address: "500 Howard Pl NW, Washington, DC 20059", description: "The Founders Library is a historic building on the campus of Howard University. It serves as a central hub for students to study and access academic resources.", imageName: "lkd"),
        Trip(id: 2, name: "Undergraduate Library", date: "2/3/25", address: "500 Howard Pl NW, Washington, DC 20059", description: "The Undergraduate Library at Howard University provides a quiet space for students to study, with access to computers, printers, and a wide range of books.", imageName: "ugl"),
        Trip(id: 3, name: "CVS", date: "2/3/25", address: "2301 Georgia Ave NW, Washington, DC 20001", description: "A convenient pharmacy and retail store offering a wide range of products including medications, health products, and groceries.", imageName: "cvs"),
        Trip(id: 4, name: "McDonald's", date: "2/5/25", address: "2400 Georgia Ave NW, Washington, DC 20001", description: "A popular fast-food restaurant offering burgers, fries, and other quick meals. It's a favorite spot for students looking for a quick bite.", imageName: "mcdonalds"),
        Trip(id: 5, name: "Howard University Hospital", date: "2/7/25", address: "2041 Georgia Ave NW, Washington, DC 20060", description: "The Howard University Hospital provides comprehensive healthcare services to the community, including emergency care, specialized treatments, and wellness programs.", imageName: "huh")
    ])
    .environmentObject(AppSettings.shared)
}
