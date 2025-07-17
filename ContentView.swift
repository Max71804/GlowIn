//
//  ContentView.swift
//  GlowIn
//
//  Created by SandboxLab on 7/8/25.
//

import SwiftUI

// MARK: - Color Extension (Now defined directly in ContentView.swift)
// This ensures the Color(hex:) initializer is always available within this file.
extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}

// MARK: - Tabmaker View
struct Tabmaker: View {
    let Task: String
    let Org: String
    let color: Color
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 160, height: 160)
                .foregroundStyle(color)
                .cornerRadius(30)
            
            Text(Task)
                .frame(width: 150, height: 100)
                .font(.title3)
                .padding(.leading, 20)
                .offset(x: -10, y: 25)
                .foregroundStyle(Color(hex:0x364F23)) // This will now correctly use the extension from this file
                .bold()
                .multilineTextAlignment(.leading)
            
            Image(Org)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .offset(x: 20, y:-35)
        }
    }
}

// MARK: - ContentView (The Feel Good Page)
struct ContentView: View {
    @State private var selectedTab: String = "Home" // Default to "Home" for this page
    @State private var showMapPage: Bool = false
    @State private var showProfilePage: Bool = false

    var body: some View {
        // Main navigation logic for the bottom bar
        if showMapPage {
            LocationView()
                .transition(.opacity)
        } else if showProfilePage {
            ProfileView() // Assuming you have a ProfileView
                .transition(.opacity)
        } else {
            ZStack {
                Color(hex: 0xFCF1C6) // This will now correctly use the extension from this file
                    .ignoresSafeArea()

                VStack {
                    HStack {
                        Text("**Feel Good**")
                            .font(.largeTitle)
                            .foregroundStyle(Color(hex: 0x364F23)) // Uses Color(hex:)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)

                    HStack(spacing: 20) {
                        Text("**Volunteering**")
                            .font(.title2)
                            .foregroundStyle(Color(hex: 0xE77E42)) // Uses Color(hex:)
                        
                        Text("**Donate**")
                            .font(.title2)
                            .foregroundStyle(Color(hex: 0xFF5D00)) // Uses Color(hex:)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)

                    HStack {
                        Text("Recent")
                            .font(.largeTitle)
                            .foregroundStyle(Color(hex: 0x5B3315)) // Uses Color(hex:)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            Tabmaker(Task: "Greater Chicago Food Depositor", Org: "greaterfoodchicago", color: Color(hex:0xFFC87B)) // Uses Color(hex:)
                            Tabmaker(Task: "Cradles to Crayons", Org: "cradlestocrayons", color: Color(hex:0x9CB62A)) // Uses Color(hex:)
                            Tabmaker(Task: "CAIR Chicago", Org: "cairchicago", color: Color(hex:0xE77E42)) // Uses Color(hex:)
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 30)

                    HStack {
                        Text("More")
                            .font(.largeTitle)
                            .foregroundStyle(Color(hex: 0x5B3315)) // Uses Color(hex:)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            Tabmaker(Task: "RefugeeOne", Org: "refugeeone", color: Color(hex:0xFFC87B)) // Uses Color(hex:)
                            Tabmaker(Task: "Care for Real", Org: "careforreal", color: Color(hex:0x9CB62A)) // Uses Color(hex:)
                            Tabmaker(Task: "Nourishing Hope", Org: "nourishinghope", color: Color(hex:0xE77E42)) // Uses Color(hex:)
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 30)

                    Spacer()

                    // MARK: - Bottom Navigation Bar
                    VStack {
                        Rectangle()
                            .fill(Color(hex: 0xF7CC86)) // Uses Color(hex:)
                            .frame(height: 90)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                            .padding(.horizontal, 10)

                        HStack(spacing: 30) {
                            Button(action: {
                                selectedTab = "Map"
                                print("Map button tapped!")
                                withAnimation {
                                    showMapPage = true
                                }
                            }) {
                                VStack {
                                    Image("Map")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    Text("Map")
                                        .font(.caption2)
                                }
                            }
                            .foregroundColor(selectedTab == "Map" ? Color(hex: 0xFF5D00) : Color(hex: 0x364F23)) // Uses Color(hex:)

                            Button(action: {
                                selectedTab = "Achievements"
                                print("Achievements button tapped!")
                                // TODO: Add navigation to AchievementsView here
                            }) {
                                VStack {
                                    Image("Achievements")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    Text("Badge")
                                        .font(.caption2)
                                }
                            }
                            .foregroundColor(selectedTab == "Achievements" ? Color(hex: 0xFF5D00) : Color(hex: 0x364F23)) // Uses Color(hex:)

                            Button(action: {
                                selectedTab = "Home"
                                print("Home button tapped!")
                                // No navigation needed, already on Home page
                            }) {
                                VStack {
                                    Image("Home")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    Text("Home")
                                        .font(.caption2)
                                }
                            }
                            .foregroundColor(selectedTab == "Home" ? Color(hex: 0xFF5D00) : Color(hex: 0x364F23)) // Uses Color(hex:)

                            Button(action: {
                                selectedTab = "Feel Good"
                                print("Feel Good button tapped!")
                                // This is the current page, so no navigation needed
                            }) {
                                VStack {
                                    Image("Feel Good")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    Text("Action")
                                        .font(.caption2)
                                }
                            }
                            .foregroundColor(selectedTab == "Feel Good" ? Color(hex: 0xFF5D00) : Color(hex: 0x364F23)) // Uses Color(hex:)

                            Button(action: {
                                selectedTab = "Account"
                                print("Account button tapped!")
                                withAnimation {
                                    showProfilePage = true // Trigger navigation to ProfileView
                                }
                            }) {
                                VStack {
                                    Image("Account")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    Text("Profile")
                                        .font(.caption2)
                                }
                            }
                            .foregroundColor(selectedTab == "Account" ? Color(hex: 0xFF5D00) : Color(hex: 0x364F23)) // Uses Color(hex:)
                        }
                        .offset(y: -50)
                    }
                    .padding(.bottom, -30)
                }
            }
        }
    }
}

// MARK: - Preview Provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
