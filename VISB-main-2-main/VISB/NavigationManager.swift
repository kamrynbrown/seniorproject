//
//  NavigationManager.swift
//  VISB
//
//  Created by Jevanie Davis on 3/17/25.
//import Foundation
import Foundation

class NavigationManager {
    static let shared = NavigationManager()

    func fetchNavigationData(start: String, destination: String, completion: @escaping ([String: Any]) -> Void) {
        let mockData: [String: Any] = [
            "route": [
                ["action": "start", "instruction": "Start at \(start). Face the main entrance and walk toward 6th Street NW."],
                ["action": "turn_right", "instruction": "Turn right onto 6th Street NW and walk straight for about 30 meters."],
                ["action": "arrive", "instruction": "You have arrived at \(destination)."]
            ],
            "waypoints": [
                ["latitude": 38.9215, "longitude": -77.0210],
                ["latitude": 38.9217, "longitude": -77.0212],
                ["latitude": 38.9219, "longitude": -77.0214]
            ],
            "commute_time": "10 minutes"
        ]

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            completion(mockData)
        }
    }

    func convertToGoogleMapsInstructions(data: [String: Any]) -> String {
        guard let route = data["route"] as? [[String: Any]] else {
            return "No route data available."
        }

        return route.compactMap { $0["instruction"] as? String }.joined(separator: "\n\n")
    }
}
