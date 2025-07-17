//
//  GlowInApp.swift
//  GlowIn
//
//  Created by SandboxLab on 7/6/25.
//

import SwiftUI

// MARK: - NavigationPathManager
// This class manages the navigation path for the entire app.
// It should be an EnvironmentObject

@main
struct GlowInApp: App {
    // Initialize the NavigationPathManager as a StateObject
    @StateObject private var navigationPath = NavigationPathManager()

    var body: some Scene {
        WindowGroup {
            // Embed your initial view (LoginPagever1) within a NavigationStack
            // and provide the NavigationPathManager as an environment object.
            NavigationStack(path: $navigationPath.path) {
                login() // Your initial login view
            }
            // MARK: - Centralized Navigation Destinations for the entire app
            // All possible navigation paths from any point in the app should be defined here.
            .navigationDestination(for: String.self) { viewID in
                switch viewID {
                case "CreateAccountView":
                    CreateAccountView()
                case "Moodtracker":
                    moodTracker()
                case "ProfileView":
                    ProfileView()
                case "LocationView":
                    LocationView()
                case "ActionView":
                    ActionView()
                case "AchievementEvaluationView":
                    // You might need to pass a 'completedQuestText' here if this is the entry point
                    AchievementEvaluationView(completedQuestText: "Your latest quest")
                case "AchievementsView":
                    WeeklyAchievementsView()
                case "HomeView":
                    Text("Placeholder for HomeView") // Ensure HomeView is defined if it's a real view
                default:
                    Text("Unknown Destination: \(viewID)")
                }
            }
            .environmentObject(navigationPath) // Make it available to all subviews
        }
    }
}
