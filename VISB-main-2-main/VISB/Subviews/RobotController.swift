//
//  RobotController.swift
//  VISB
//
//  Created by Jevanie Davis on 3/14/25.
//
import Foundation

class RobotController: ObservableObject {
    static let shared = RobotController()

    func sendInstructions(_ instructions: String) {
        // Simulate sending instructions to the robot
        print("Simulated instructions sent to robot: \(instructions)")
        AlertManager.shared.notifyUser(message: "Instructions sent to robot.")
    }
}
