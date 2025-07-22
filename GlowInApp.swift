import SwiftUI

@main
struct GlowInApp: App {
    @StateObject private var navigationPath = NavigationPathManager()
    @StateObject private var mood = moodModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationPath.path) {
                WelcomePage()
                // MARK: - Move navigationDestination INSIDE NavigationStack
                .navigationDestination(for: String.self) { viewID in
                    switch viewID {
                    case "LoginPagever1":
                        login()
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
                        AchievementEvaluation(completedQuestText: "Your latest quest")
                    case "AchievementsView":
                        WeeklyAchievementsView()
                    case "HomeView":
                        HomeView()
                    default:
                        Text("Unknown Destination: \(viewID)")
                    }
                }
            }
            .environmentObject(navigationPath)
            .environmentObject(mood)
            
        }
    }
}
