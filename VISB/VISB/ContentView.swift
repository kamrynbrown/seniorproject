//
//  ContentView.swift
//  VISB
//

import SwiftUI

struct ContentView: View {
    @State var heightRatio: CGFloat = UIScreen.main.bounds.height/2
    var body: some View {
        VStack {
            NavigationStack {
                ZStack {
                    Rectangle().ignoresSafeArea()
                        .foregroundStyle(.blue)
                        .frame(maxHeight: heightRatio)
                    HStack {
                        Image("Robot")
                            .resizable()
                            .frame(width: 204, height: 374.25)
                            .accessibilityLabel("Picture of robot")
                        Spacer().frame(width: 50)
                        Text("100%")
                    }
                    .foregroundStyle(.white)
                    .padding(.trailing)
                }
                Spacer()
                NavigationLink {
                    NavigationView()
                } label : {
                    Text("Start Navigation").frame(maxWidth: .infinity)
                }
                
                .buttonStyle(LongButton()).padding(.horizontal)
                NavigationLink {
                    HistoryView(trips: [Trip(id: 0, name: "Howard Plaza Towers to LKD", date: "2/1/25"), Trip(id: 1, name: "Undergraduate Library to CVS", date: "2/3/25")])
                } label : {
                    Text("Trips History").frame(maxWidth: .infinity)
                }
                .buttonStyle(LongButton()).padding(.horizontal)
                NavigationLink {
                    EmergencyView()
                } label : {
                    Text("Emergency").frame(maxWidth: .infinity)
                }
                .buttonStyle(LongButton()).padding(.horizontal)
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct LongButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .padding()
            .background(Color(red: 0, green: 0.35, blue: 0.9))
            .opacity(configuration.isPressed ? 0.8 : 1)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 15))
            
    }
}
