//import SwiftUI

import SwiftUI
// REMOVED: import AchievementsView // This line would cause "No such module" if AchievementsView is in the same target

struct ProfileView: View {
    // State to manage which tab is currently selected (optional, but good for real navigation)
    @State private var selectedTab: String = "Profile" // Default to Profile tab

    @EnvironmentObject var navigationPath: NavigationPathManager
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            // Background Color
            Color(red: 0.96, green: 0.95, blue: 0.88) // Light beige background
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                // MARK: - Top Bar (Back Button)
                HStack {
                    Button(action: {
                        dismiss()
                        print("Back button tapped from ProfileView")
                    }) {
                        Image(systemName: "arrow.backward")
                            .font(.title2)
                            .foregroundColor(Color(red: 0.25, green: 0.35, blue: 0.20)) // Dark green
                            .padding(.leading, 20)
                    }
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.bottom, 20)

                // MARK: - Profile Picture
                Image("Pfp")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 110, height: 110) // Slightly smaller profile picture
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color(red: 0.25, green: 0.35, blue: 0.20), lineWidth: 3))
                    .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                    .padding(.bottom, 10) // Reduced padding

                // MARK: - "edit profile" text
                Text("edit profile")
                    .font(.custom("Inter-Medium", size: 14)) // Slightly smaller font
                    .foregroundColor(Color(red: 0.25, green: 0.35, blue: 0.20).opacity(0.8))
                    .padding(.bottom, 15) // Reduced padding

                // MARK: - Name
                Text("Hooriya Kazmi")
                    .font(.custom("Inter-Bold", size: 30)) // Slightly smaller font
                    .foregroundColor(Color(red: 0.94, green: 0.45, blue: 0.24))
                    .padding(.bottom, 25) // Reduced padding

                // MARK: - Profile Information Details
                VStack(alignment: .leading, spacing: 15) { // Reduced spacing between detail lines
                    // Username
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Username")
                            .font(.custom("Inter-SemiBold", size: 15)) // Slightly smaller font
                            .foregroundColor(Color(red: 0.25, green: 0.35, blue: 0.20))
                        Text("hkazmi312@gmail.com")
                            .font(.custom("Inter-Regular", size: 16)) // Slightly smaller font
                            .foregroundColor(Color(red: 0.25, green: 0.35, blue: 0.20).opacity(0.9))
                    }

                    // Password
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Password")
                            .font(.custom("Inter-SemiBold", size: 15)) // Slightly smaller font
                            .foregroundColor(Color(red: 0.25, green: 0.35, blue: 0.20))
                        Text("************")
                            .font(.custom("Inter-Regular", size: 16)) // Slightly smaller font
                            .foregroundColor(Color(red: 0.25, green: 0.35, blue: 0.20).opacity(0.9))
                    }

                    // Zip Code
                    VStack(alignment: .leading, spacing: 2) {
                        Text("ZipCode")
                            .font(.custom("Inter-SemiBold", size: 15)) // Slightly smaller font
                            .foregroundColor(Color(red: 0.25, green: 0.35, blue: 0.20))
                        Text("60626")
                            .font(.custom("Inter-Regular", size: 16)) // Slightly smaller font
                            .foregroundColor(Color(red: 0.25, green: 0.35, blue: 0.20).opacity(0.9))
                    }
                }
                .padding(.horizontal, 40)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 30) // Reduced padding

                // MARK: - Your Mood, Streak, Achievements Section (Creative & Vibrant)
                VStack(spacing: 0) {
                    Text("your mood")
                        .font(.custom("Inter-SemiBold", size: 18)) // Slightly smaller title
                        .foregroundColor(Color(red: 0.94, green: 0.45, blue: 0.24))
                        .padding(.bottom, 10) // Reduced padding

                    ZStack {
                        // Main mood background card (large, rounded rectangle with gradient)
                        RoundedRectangle(cornerRadius: 30) // Slightly less rounded
                            .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 255/255, green: 220/255, blue: 100/255), Color(red: 255/255, green: 180/255, blue: 50/255)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 260, height: 260) // Smaller size
                            .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 6) // Slightly smaller shadow

                        // Content for mood (centered within the main card)
                        VStack(spacing: 8) { // Reduced spacing
                            Image("happy") // Assuming 'happy' is an asset for current mood
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100) // Smaller mood icon
                                .padding(.bottom, 0)
                        }

                        // Streak Card (positioned on top, slightly offset)
                        HStack {
                            VStack(spacing: 4) { // Reduced spacing
                                Image(systemName: "flame.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24) // Smaller icon
                                    .foregroundColor(.white)
                                Text("6")
                                    .font(.custom("Inter-Bold", size: 26)) // Smaller font
                                    .foregroundColor(.white)
                                Text("streak")
                                    .font(.custom("Inter-Regular", size: 13)) // Smaller font
                                    .foregroundColor(.white.opacity(0.9))
                            }
                            .padding(.vertical, 12) // Reduced padding
                            .padding(.horizontal, 18) // Reduced padding
                            .background(Color(red: 0.94, green: 0.45, blue: 0.24))
                            .cornerRadius(18) // Slightly less rounded
                            .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 2)
                        }
                        .offset(x: -80, y: -80) // Adjusted offset

                        // Achievements Card (positioned on top, slightly offset)
                        HStack {
                            VStack(spacing: 4) { // Reduced spacing
                                Image(systemName: "trophy.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24) // Smaller icon
                                    .foregroundColor(.white)
                                Text("34")
                                    .font(.custom("Inter-Bold", size: 26)) // Smaller font
                                    .foregroundColor(.white)
                                Text("achievements")
                                    .font(.custom("Inter-Regular", size: 13)) // Smaller font
                                    .foregroundColor(.white.opacity(0.9))
                            }
                            .padding(.vertical, 12) // Reduced padding
                            .padding(.horizontal, 18) // Reduced padding
                            .background(Color(red: 54/255, green: 79/255, blue: 35/255))
                            .cornerRadius(18) // Slightly less rounded
                            .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 2)
                        }
                        .offset(x: 80, y: 80) // Adjusted offset
                    }
                }
                .padding(.horizontal, 20) // Reduced horizontal padding for the entire block
                .padding(.bottom, 15) // Reduced padding

                Spacer() // Pushes content towards the bottom nav bar

                // MARK: - Bottom Navigation Bar
                VStack {
                    Divider()
                        .background(Color(red: 0.25, green: 0.35, blue: 0.20).opacity(0.4))
                        .padding(.horizontal, -20)

                    HStack {
                        Spacer()
                        // Location Icon
                        Button(action: {
                            selectedTab = "Location"
                            print("Location tab tapped")
                            navigationPath.path = NavigationPath()
                            navigationPath.path.append("LocationView")
                        }) {
                            VStack {
                                Image(systemName: "location.fill")
                                    .font(.title2)
                                Text("Location")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Location" ? Color(red: 0.94, green: 0.45, blue: 0.24) : Color(red: 0.25, green: 0.35, blue: 0.20))
                        Spacer()

                        // Badge Icon (Navigate to AchievementEvaluationView)
                        Button(action: {
                            selectedTab = "Badge"
                            print("Badge tab tapped, navigating to AchievementEvaluationView")
                            navigationPath.path = NavigationPath() // Clear path
                            navigationPath.path.append("AchievementEvaluationView")
                        }) {
                            VStack {
                                Image(systemName: "rosette")
                                    .font(.title2)
                                Text("Badge")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Badge" ? Color(red: 0.94, green: 0.45, blue: 0.24) : Color(red: 0.25, green: 0.35, blue: 0.20))
                        Spacer()

                        // Home Icon
                        Button(action: {
                            selectedTab = "Home"
                            print("Home tab tapped")
                            navigationPath.path = NavigationPath()
                            navigationPath.path.append("HomeView")
                        }) {
                            VStack {
                                Image(systemName: "house.fill")
                                    .font(.title2)
                                Text("Home")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Home" ? Color(red: 0.94, green: 0.45, blue: 0.24) : Color(red: 0.25, green: 0.35, blue: 0.20))
                        Spacer()

                        // Action Icon (Navigate to ActionView)
                        Button(action: {
                            selectedTab = "Action"
                            print("Action tab tapped, navigating to ActionView")
                            navigationPath.path = NavigationPath()
                            navigationPath.path.append("ActionView")
                        }) {
                            VStack {
                                Image(systemName: "hand.raised.fill")
                                    .font(.title2)
                                Text("Action")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Action" ? Color(red: 0.94, green: 0.45, blue: 0.24) : Color(red: 0.25, green: 0.35, blue: 0.20))
                        Spacer()

                        // Person Icon (Current Page)
                        Button(action: {
                            selectedTab = "Profile"
                            print("Profile tab tapped (already on ProfileView)")
                            // This is the current view, so no navigation needed, or pop to root of Profile tab
                        }) {
                            VStack {
                                Image(systemName: "person.fill")
                                    .font(.title2)
                                Text("Profile")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Profile" ? Color(red: 0.94, green: 0.45, blue: 0.24) : Color(red: 0.25, green: 0.35, blue: 0.20))
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .background(Color(red: 0.96, green: 0.95, blue: 0.88))
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -2)
                }
                .padding(.bottom, 0)
            }
            .navigationDestination(for: String.self) { viewID in
                if viewID == "Moodtracker" {
                    moodTracker()
                } else if viewID == "AchievementsView" {
                    WeeklyAchievementsView()
                } else if viewID == "LocationView" {
                    LocationView() // Changed from placeholder
                } else if viewID == "HomeView" {
                    Text("Placeholder for HomeView")
                } else if viewID == "ActionView" {
                    ActionView()
                } else if viewID == "AchievementEvaluationView" { // Added AchievementEvaluationView
                    // You might need to pass a 'completedQuestText' here if this is the entry point
                    AchievementEvaluationView(completedQuestText: "Your latest quest")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Preview Provider
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView()
                .environmentObject(NavigationPathManager())
        }
    }
}
