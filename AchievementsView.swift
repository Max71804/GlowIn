//  Created by YourName on 7/13/25.
//  (Adjust date and name)
//

import SwiftUI

struct WeeklyAchievementsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navigationPath: NavigationPathManager

    // Define custom colors based on the screenshot
    let lightBeige = Color(red: 0.96, green: 0.95, blue: 0.88) // #F5F3E1
    let darkGreen = Color(red: 54/255, green: 79/255, blue: 35/255) // #364F23
    let trophyOrange = Color(red: 0.94, green: 0.45, blue: 0.24) // #EF733D

    // Mock data for weekly achievements
    let weeklyAchievements: [Achievement] = [
        Achievement(text: "smile at a stranger", date: "3/1/25", color: Color(red: 228/255, green: 236/255, blue: 196/255)), // Light Green
        Achievement(text: "compliment a stranger", date: "3/1/25", color: Color(red: 228/255, green: 236/255, blue: 196/255)), // Light Green
        Achievement(text: "tell someone you appreciate them", date: "3/2/25", color: Color(red: 161/255, green: 165/255, blue: 147/255)), // Gray Green
        Achievement(text: "reach out to a distant friend", date: "3/3/25", color: Color(red: 255/255, green: 247/255, blue: 196/255)), // Light Yellow
        Achievement(text: "call a distant family member", date: "3/4/25", color: Color(red: 255/255, green: 247/255, blue: 196/255)), // Light Yellow
        Achievement(text: "give someone a small gift", date: "3/5/25", color: Color(red: 204/255, green: 193/255, blue: 230/255)), // Light Purple
        Achievement(text: "thank someone", date: "3/6/25", color: Color(red: 240/255, green: 153/255, blue: 110/255)) // Light Orange
    ]

    var body: some View {
        ZStack {
            lightBeige.ignoresSafeArea()

            VStack(spacing: 20) {
                // MARK: - Top Bar (Back Button)
                HStack {
                    Button(action: {
                        dismiss() // Go back to the previous view
                        print("Back button tapped from WeeklyAchievementsView")
                    }) {
                        Image(systemName: "arrow.backward")
                            .font(.title2)
                            .foregroundColor(darkGreen)
                            .padding(.leading, 20)
                    }
                    Spacer()
                }
                .padding(.top, 20)

                // MARK: - Weekly Achievements Title
                HStack {
                    Text("Weekly\nAchievements")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(darkGreen)
                        .padding(.leading, 20)
                    Spacer()
                    VStack(alignment: .trailing) {
                        Image(systemName: "calendar")
                            .font(.title2)
                            .foregroundColor(darkGreen)
                        Text("June 29 - July 5") // Dynamic date range
                            .font(.caption)
                            .foregroundColor(darkGreen)
                    }
                    .padding(.trailing, 20)
                }
                .padding(.bottom, 10)

                // MARK: - Achievements List
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(weeklyAchievements) { achievement in
                            AchievementCard(achievement: achievement)
                        }
                    }
                    .padding(.horizontal, 20)
                }

                Spacer() // Pushes content up

                // MARK: - Bottom Navigation Bar (replicated for consistency)
                VStack {
                    Divider()
                        .background(darkGreen.opacity(0.3))
                        .padding(.horizontal, -20)

                    HStack {
                        Spacer()
                        // Location Icon
                        Button(action: {
                            navigationPath.path = NavigationPath() // Clear path
                            navigationPath.path.append("LocationView")
                            print("Location tab tapped")
                        }) {
                            VStack {
                                Image(systemName: "location.fill")
                                    .font(.title2)
                                Text("Location")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Location" ? trophyOrange : darkGreen)
                        Spacer()

                        // Badge Icon (Current Page)
                        Button(action: {
                            // Already on this page, no navigation needed
                            selectedTab = "Badge" // Keep it highlighted
                            print("Badge tab tapped (already on AchievementsView)")
                        }) {
                            VStack {
                                Image(systemName: "rosette")
                                    .font(.title2)
                                Text("Badge")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Badge" ? trophyOrange : darkGreen) // Highlighted
                        Spacer()

                        // Home Icon
                        Button(action: {
                            navigationPath.path = NavigationPath() // Clear path
                            navigationPath.path.append("HomeView")
                            print("Home tab tapped")
                        }) {
                            VStack {
                                Image(systemName: "house.fill")
                                    .font(.title2)
                                Text("Home")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Home" ? trophyOrange : darkGreen)
                        Spacer()

                        // Action Icon
                        Button(action: {
                            navigationPath.path = NavigationPath() // Clear path
                            navigationPath.path.append("ActionView")
                            print("Action tab tapped")
                        }) {
                            VStack {
                                Image(systemName: "hand.raised.fill")
                                    .font(.title2)
                                Text("Action")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Action" ? trophyOrange : darkGreen)
                        Spacer()

                        // Profile Icon
                        Button(action: {
                            navigationPath.path = NavigationPath() // Clear path
                            navigationPath.path.append("ProfileView")
                            print("Profile tab tapped")
                        }) {
                            VStack {
                                Image(systemName: "person.fill")
                                    .font(.title2)
                                Text("Profile")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Profile" ? trophyOrange : darkGreen)
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .background(lightBeige)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                }
                .padding(.bottom, 0)
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    @State private var selectedTab: String = "Badge" // Default to Badge
}

// MARK: - Achievement Data Model
struct Achievement: Identifiable {
    let id = UUID()
    let text: String
    let date: String
    let color: Color
}

// MARK: - AchievementCard Sub-View
struct AchievementCard: View {
    let achievement: Achievement

    let darkGreen = Color(red: 54/255, green: 79/255, blue: 35/255)
    let trophyOrange = Color(red: 0.94, green: 0.45, blue: 0.24)

    var body: some View {
        HStack {
            Image(systemName: "trophy.fill")
                .foregroundColor(trophyOrange)
                .font(.title2)
                .padding(.leading, 10)
            Text(achievement.text)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(darkGreen)
            Spacer()
            Text(achievement.date)
                .font(.subheadline)
                .foregroundColor(darkGreen.opacity(0.8))
                .padding(.trailing, 10)
        }
        .padding(.vertical, 15)
        .background(achievement.color)
        .cornerRadius(15)
        .shadow(radius: 3)
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Preview Provider
struct WeeklyAchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WeeklyAchievementsView()
                .environmentObject(NavigationPathManager())
        }
    }
}
