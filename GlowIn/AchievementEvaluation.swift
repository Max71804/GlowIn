import SwiftUI

struct AchievementEvaluation: View {
    // Access the NavigationPathManager from the environment
    @EnvironmentObject var navigationPath: NavigationPathManager

    // State to manage the glow points, if they were dynamic
    @State private var glowPoints: Int = 6
    // Make completedQuestText optional with a default fallback
    let completedQuestText: String?

    // State to hold the user's selected rating (1 to 5)
    @State private var selectedRating: Int? = nil

    // Define the emojis and their corresponding colors for the rating scale
    // Colors are now reversed: 1 (red) to 5 (dark green)
    let ratingEmojis: [(String, Color)] = [
        ("face.nauseated.fill", Color(red: 180/255, green: 60/255, blue: 60/255)),  // Red - Very Sad (for rating 1)
        ("face.frowning.fill", Color(red: 220/255, green: 130/255, blue: 70/255)), // Orange-Brown - Sad (for rating 2)
        ("face.dashed.fill", Color(red: 236/255, green: 179/255, blue: 62/255)), // Yellow/Orange - Neutral (for rating 3)
        ("face.smiling.fill", Color(red: 120/255, green: 160/255, blue: 80/255)), // Lighter Green - Happy (for rating 4)
        ("smiley.fill", Color(red: 76/255, green: 112/255, blue: 70/255)) // Dark Green - Very Happy (for rating 5)
    ]

    var body: some View {
        ZStack {
            // Background color for the entire screen
            Color(red: 247/255, green: 243/255, blue: 229/255) // Light beige background
                .edgesIgnoringSafeArea(.all)

            VStack {
                // Trophy Icon - Now using your custom image asset
                Image("Achievement") // Use your image asset name here
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    // .foregroundColor(Color(red: 236/255, green: 179/255, blue: 62/255)) // Remove this line for custom images
                    .offset(y: 50) // Adjust position to overlap the card

                Spacer() // Pushes the trophy up and the card down

                // Main Content Card
                VStack(spacing: 20) {
                    // Top section of the card
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text("Yay!")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                            // Glow points
                            HStack(spacing: 5) {
                                Image(systemName: "flame.fill")
                                    .foregroundColor(.white)
                                Text("\(glowPoints)")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.orange.opacity(0.8)) // Adjust color to match screenshot
                            .cornerRadius(15)
                        }
                        // Use the dynamic completedQuestText here, with a fallback if nil
                        Text(completedQuestText ?? "You completed a quest!") // Default text if nil
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    .padding(.top, 70) // Push content down to make space for trophy
                    .padding(.bottom, 20)
                    .background(Color(red: 220/255, green: 130/255, blue: 70/255)) // Orange-brown top section
                    .cornerRadius(25, corners: [.topLeft, .topRight]) // Rounded top corners

                    // Rating Scale Section
                    VStack(spacing: 10) {
                        // Numbers 1-5
                        HStack {
                            ForEach(1...5, id: \.self) { number in
                                Text("\(number)")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(.horizontal, 10) // Match padding of the bar below

                        // Gradient Bar - Colors are now reversed
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 180/255, green: 60/255, blue: 60/255),  // Red (for rating 1)
                                    Color(red: 220/255, green: 130/255, blue: 70/255), // Orange-Brown (for rating 2)
                                    Color(red: 236/255, green: 179/255, blue: 62/255), // Yellow/Orange (for rating 3)
                                    Color(red: 120/255, green: 160/255, blue: 80/255), // Lighter Green (for rating 4)
                                    Color(red: 76/255, green: 112/255, blue: 70/255) // Dark Green (for rating 5)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ))
                            .frame(height: 20)
                            .padding(.horizontal) // Padding from the card edges

                        // Emoji/Icon Buttons
                        HStack(spacing: 15) { // Adjusted spacing for 5 items
                            ForEach(0..<ratingEmojis.count, id: \.self) { index in
                                Button(action: {
                                    selectedRating = index + 1 // Set rating from 1 to 5
                                }) {
                                    Image(systemName: ratingEmojis[index].0) // SF Symbol name
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 35, height: 35) // Slightly smaller icons
                                        .foregroundColor(.white)
                                        .padding(10) // Padding inside the circle
                                        .background(ratingEmojis[index].1) // Background color for emoji
                                        .clipShape(Circle())
                                        .overlay( // Add a border if selected
                                            Circle()
                                                .stroke(selectedRating == index + 1 ? Color.blue : Color.clear, lineWidth: 3)
                                        )
                                        .scaleEffect(selectedRating == index + 1 ? 1.1 : 1.0) // Pop effect
                                        .animation(.spring(), value: selectedRating) // Smooth animation
                                }
                            }
                        }
                        .padding(.vertical, 10)
                    }
                    .padding(.top, 20)

                    Spacer() // Pushes content up, "done" button down

                    // Bottom section with character and done button
                    HStack {
                        // Custom image for the user character
                        // IMPORTANT: Replace "YourCustomUserImage" with the actual name of your image asset
                        // Make sure the image is added to your Assets.xcassets in Xcode.
                        Image("Tomato") // Placeholder for your custom image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90, height: 120) // Increased size
                            // Remove .foregroundColor as it's for SF Symbols/shapes
                            .offset(x: 10, y: -15) // Adjusted offset for new size
                        Spacer()

                        // Done Button
                        Button(action: {
                            // Action for "done"
                            print("Done button tapped! Selected Rating: \(selectedRating ?? 0)")
                            // Navigate to AchievementsView
                            navigationPath.path.append("AchievementsView")
                        }) {
                            Text("done")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 30)
                                .padding(.vertical, 15)
                                .background(Color(red: 220/255, green: 130/255, blue: 70/255)) // Orange-brown color
                                .cornerRadius(30)
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                    }
                }
                .background(Color(red: 250/255, green: 247/255, blue: 236/255)) // Light yellow-beige bottom section
                .cornerRadius(25)
                .shadow(radius: 10) // Subtle shadow for the card
                .padding(.horizontal, 30) // Padding from screen edges
                .padding(.bottom, 50) // Adjust overall vertical position
            }
        }
    }
}

// Helper extension for specific corner radius
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// MARK: - Preview Provider
struct AchievementEvaluation_Previews: PreviewProvider {
    static var previews: some View {
        // Now requires the completedQuestText parameter for the preview
        AchievementEvaluation(completedQuestText: "You completed the quest")
            .environmentObject(NavigationPathManager()) // Provide a dummy NavigationPathManager for preview
    }
}
