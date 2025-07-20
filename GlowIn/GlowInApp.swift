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
            // Embed your initial view (WelcomePage) within a NavigationStack
            // and provide the NavigationPathManager as an environment object.
            NavigationStack(path: $navigationPath.path) {
                WelcomePage() // <--- Change this line to WelcomePage()
            }
            // MARK: - Centralized Navigation Destinations for the entire app
            // All possible navigation paths from any point in the app should be defined here.
            .navigationDestination(for: String.self) { viewID in
                switch viewID {
                case "WelcomePage":
                    WelcomePage()
                case "LoginPagever1": // Add this case if login() is for LoginPagever1
                    login() // Your LoginPagever1 struct/function
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
                    AchievementEvaluation(completedQuestText: "Your latest quest")
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
