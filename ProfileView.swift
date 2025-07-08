//import SwiftUI

import SwiftUI

struct ProfileView: View {
    // State to manage which tab is currently selected (optional, but good for real navigation)
    @State private var selectedTab: String = "Profile" // Default to Profile tab

    var body: some View {
        ZStack {
            // Background Color
            Color(red: 0.96, green: 0.95, blue: 0.88) // Light beige background
                .edgesIgnoringSafeArea(.all)

            VStack {
                // MARK: - Top Bar (Back Button)
                HStack {
                    Button(action: {
                        // Action for back button
                        print("Back button tapped")
                        // In a real app, you would dismiss this view, e.g., environment(\.presentationMode).wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.backward") // System icon for back arrow
                            .font(.title2)
                            .foregroundColor(Color(red: 0.25, green: 0.35, blue: 0.20)) // Dark green
                            .padding(.leading, 20)
                    }
                    Spacer()
                }
                .padding(.top, 20) // Adjust padding from top of screen

                // MARK: - Profile Picture
                // Make sure 'image_077a69' is added to your Assets.xcassets
                Image("Pfp")
                    .resizable()
                    .aspectRatio(contentMode: .fill) // Fill the circle
                    .frame(width: 120, height: 120) // Adjust size as needed
                    .clipShape(Circle()) // Clip to a circle
                    .overlay(Circle().stroke(Color(red: 0.25, green: 0.35, blue: 0.20), lineWidth: 2)) // Add a border
                    .shadow(radius: 5) // Add a subtle shadow
                    .padding(.top, 20) // Space from the top bar
                    .padding(.bottom, 10) // Space before "edit profile"

                // MARK: - "edit profile" text
                Text("edit profile")
                    .font(.custom("Inter-Regular", size: 16)) // Adjust font and size
                    .foregroundColor(Color(red: 0.25, green: 0.35, blue: 0.20)) // Dark green text
                    .padding(.bottom, 10) // Extra space below "edit profile"

                // MARK: - Name
                Text("Hooriya Kazmi")
                    .font(.custom("Inter-Bold", size: 30)) // Bold and larger for name
                    .foregroundColor(Color(red: 0.94, green: 0.45, blue: 0.24)) // Orange color
                    .padding(.bottom, 30) // Space after name, before details

                // MARK: - Profile Information Details
                VStack(alignment: .leading, spacing: 15) { // Spacing between elements
                    // Email
                    Text("email: hkazmi312@gmail.com")
                        .font(.custom("Inter-Regular", size: 18))
                        .foregroundColor(Color(red: 0.25, green: 0.35, blue: 0.20))

                    // Password
                    Text("password: **************")
                        .font(.custom("Inter-Regular", size: 18))
                        .foregroundColor(Color(red: 0.25, green: 0.35, blue: 0.20))

                    // Zip Code
                    Text("Zip Code: 60626")
                        .font(.custom("Inter-Regular", size: 18))
                        .foregroundColor(Color(red: 0.25, green: 0.35, blue: 0.20))
                }
                .padding(.horizontal, 40) // Horizontal padding for the text block
                .frame(maxWidth: .infinity, alignment: .leading) // Align text to leading edge

                Spacer() // Pushes content towards the top

                // MARK: - Bottom Navigation Bar
                VStack {
                    Divider() // A subtle line above the tab bar
                        .background(Color(red: 0.25, green: 0.35, blue: 0.20).opacity(0.3))
                        .padding(.horizontal, -20) // Extend divider slightly

                    HStack {
                        Spacer()
                        // Location Icon
                        Button(action: {
                            selectedTab = "Location"
                            print("Location tab tapped")
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

                        // Badge Icon
                        Button(action: {
                            selectedTab = "Badge"
                            print("Badge tab tapped")
                        }) {
                            VStack {
                                Image(systemName: "rosette") // Using rosette for badge
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

                        // Fist Icon (using a placeholder hand.raised.fill)
                        Button(action: {
                            selectedTab = "Action"
                            print("Action tab tapped")
                        }) {
                            VStack {
                                Image(systemName: "hand.raised.fill")
                                    .font(.title2)
                                Text("Action") // Or whatever this icon represents
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Action" ? Color(red: 0.94, green: 0.45, blue: 0.24) : Color(red: 0.25, green: 0.35, blue: 0.20))
                        Spacer()

                        // Person Icon
                        Button(action: {
                            selectedTab = "Profile"
                            print("Profile tab tapped")
                        }) {
                            VStack {
                                Image(systemName: "person.fill")
                                    .font(.title2)
                                Text("Profile")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Profile" ? Color(red: 0.94, green: 0.45, blue: 0.24) : Color(red: 0.25, green: 0.35, blue: 0.20)) // Orange for selected/current tab
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .background(Color(red: 0.96, green: 0.95, blue: 0.88)) // Match background color
                    .cornerRadius(20) // Rounded corners for the bottom bar
                    .shadow(radius: 5) // Subtle shadow
                }
                .padding(.bottom, 0) // No padding at the very bottom
            }
        }
    }
}

// MARK: - Preview Provider
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
