//
//  EmergencyView.swift
//  VISB
//
//  Created by courtneymahugu on 1/30/25.
//

import SwiftUI

struct EmergencyView: View {
    @State var heightRatio: CGFloat = UIScreen.main.bounds.height/2
    var body: some View {
        VStack {
            Button {
                open(link: "tel://1")
            } label: {
                Text("Call 911").frame(maxWidth: .infinity)
            }
            .buttonStyle(LongButton()).padding(.horizontal)
            Button {
                // Call emergency contact OR build a profile view
                open(link: "tel://18882804331")
            } label: {
                Text("Emergency Contact").frame(maxWidth: .infinity)
            }
            .buttonStyle(LongButton()).padding(.horizontal)
            Button {
                // Make call to robot
                print("To robot: reset")
                print("Robot has been reset!")
            } label: {
                Text("Reset Robot").frame(maxWidth: .infinity)
            }
            .buttonStyle(LongButton()).padding(.horizontal)
            Button {
                // Call Amazon on tel
                open(link: "https://www.amazon.com/gp/help/customer/contact-us")
            } label: {
                Text("Report to Amazon").frame(maxWidth: .infinity)
            }
            .buttonStyle(LongButton()).padding(.horizontal)
        }
        .navigationTitle("Emergency Options")
    }
}

#Preview {
    EmergencyView()
}

func open(link: String) {
    if let url = URL(string: link), UIApplication.shared.canOpenURL(url) {
        // Safe to open the application using open
        UIApplication.shared.open(url)
    } else {
        print("Error opening this link")
    }
}
