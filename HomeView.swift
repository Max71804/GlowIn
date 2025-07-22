import SwiftUI
import Combine // Required for Timer and AnyCancellable

// MARK: - Custom Color Extensions
// Define custom colors used throughout the application for consistency.
extension Color {
    static let primaryOrange = Color(red: 0.93, green: 0.45, blue: 0.24) // #EE733E
    static let secondaryYellow = Color(red: 0.97, green: 0.96, blue: 0.88) // #F8F5E0 - Main background
    static let cardOrangeLight = Color(red: 0.97, green: 0.88, blue: 0.77) // #F8E0C4 - Lighter orange for mood tracker
    static let darkGreen = Color(red: 0.25, green: 0.35, blue: 0.20) // #405933 - Dark green for text/accents

    // Mood tracker specific colors (approximations from screenshot)
    static let moodYellow = Color(red: 0.99, green: 0.94, blue: 0.56) // #FEEF8E
    static let moodLightGreen = Color(red: 0.85, green: 0.93, blue: 0.70) // #D9ED92
    static let moodPurple = Color(red: 0.69, green: 0.69, blue: 0.88) // #B0B0E0
    static let moodBrown = Color(red: 0.85, green: 0.63, blue: 0.49) // #D9A07D
    static let moodGray = Color(red: 0.72, green: 0.72, blue: 0.72) // #B8B8B8
}

// MARK: - MoodIconView (Helper View for Mood Tracker Emojis)
// A reusable component for displaying a mood emoji within a colored circle.
struct MoodIconView: View {
    let emoji: String
    let backgroundColor: Color

    var body: some View {
        ZStack {
            Circle()
                .fill(backgroundColor)
                .frame(width: 45, height: 45) // Slightly enlarged mood icons
                .shadow(radius: 1.5) // Slightly increased shadow

            Text(emoji)
                .font(.title) // Slightly enlarged font size for emojis
        }
    }
}

// MARK: - HomeTab (Main View)
// This is the main SwiftUI view that constructs the entire HomeTab interface.
struct HomeTab: View {
    // State to manage the currently selected tab in the bottom navigation bar.
    @State private var selectedTab: String = "Home"

    // MARK: - Real-time countdown properties
    @State private var remainingTime: TimeInterval = 0
    @State private var cancellable: AnyCancellable? = nil

    // State for the editable journal text
    @State private var journalText: String = "write away"

    // Formatter for time display (HH:MM:SS)
    private let timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        formatter.unitsStyle = .positional
        return formatter
    }()

    var body: some View {
        // Use a ZStack to layer content, allowing the navigation bar to float at the bottom.
        ZStack(alignment: .bottom) {
            // Main ScrollView for the content, allowing it to scroll if it exceeds screen height.
            // Removed showsIndicators: false to allow scroll indicator for long content
            ScrollView(.vertical) {
                VStack(spacing: 15) { // Increased overall spacing for larger blocks
                    // MARK: - Top Section (Welcome Message and User Avatar)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("welcome back,")
                                .font(.system(size: 16)) // Slightly enlarged font size
                                .foregroundColor(.darkGreen)
                            Text("Hooriya Kazmi")
                                .font(.system(size: 26)) // Slightly enlarged font size
                                .fontWeight(.bold)
                                .foregroundColor(.primaryOrange)
                        }
                        Spacer()

                        // User Avatar (Using "Pfp" asset)
                        Image("Pfp") // Make sure "Pfp" asset is in Assets.xcassets
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 55, height: 55) // Slightly enlarged size
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.darkGreen, lineWidth: 2))
                            .shadow(radius: 3)
                    }
                    .padding(.horizontal, 20) // Adjusted horizontal padding
                    .padding(.top, 20) // Adjusted top padding

                    // MARK: - Daily Quest Card
                    VStack(alignment: .leading, spacing: 10) { // Increased spacing
                        HStack(alignment: .center) {
                            Image(systemName: "trophy.fill")
                                .font(.title2) // Slightly enlarged font size
                                .foregroundColor(.white)
                            Text("Daily Quest:")
                                .font(.system(size: 18)) // Slightly enlarged font size
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("time left:")
                                    .font(.caption) // Adjusted font size
                                    .foregroundColor(.white.opacity(0.8))
                                Text(timeFormatter.string(from: remainingTime) ?? "00:00:00")
                                    .font(.system(size: 16)) // Slightly enlarged font size
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        }

                        Text("Smile at a Stranger")
                            .font(.system(size: 22)) // Slightly enlarged font size
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 8) // Slightly increased vertical padding

                        HStack {
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(Color.white.opacity(0.3))
                                    .frame(height: 8) // Slightly increased height
                                Capsule()
                                    .fill(Color.white)
                                    .frame(width: 0, height: 8) // Placeholder for 0% progress
                            }
                            .frame(maxWidth: .infinity)

                            Text("0%")
                                .font(.caption2)
                                .foregroundColor(.white)

                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.white)
                                .font(.caption)

                            Image(systemName: "flame.fill")
                                .foregroundColor(.red)
                                .font(.caption)
                            Text("6")
                                .font(.caption2)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(18) // Increased padding for larger block
                    .background(Color.primaryOrange)
                    .cornerRadius(20) // Slightly increased corner radius
                    .shadow(radius: 4)
                    .padding(.horizontal, 20) // Adjusted horizontal padding

                    // MARK: - Mood Tracker Card
                    VStack(spacing: 20) { // Increased spacing
                        Text("Mood Tracker")
                            .font(.system(size: 18)) // Slightly enlarged font size
                            .fontWeight(.semibold)
                            .foregroundColor(.darkGreen)
                            .multilineTextAlignment(.center)

                        HStack(spacing: 15) { // Increased spacing between mood icons
                            MoodIconView(emoji: "😊", backgroundColor: .moodYellow)
                            MoodIconView(emoji: "🙂", backgroundColor: .moodLightGreen)
                            MoodIconView(emoji: "😐", backgroundColor: .moodPurple)
                            MoodIconView(emoji: "😟", backgroundColor: .moodBrown)
                            MoodIconView(emoji: "😞", backgroundColor: .moodGray)
                        }
                    }
                    .padding(.vertical, 15) // Increased vertical padding
                    .background(Color.cardOrangeLight)
                    .cornerRadius(20) // Slightly increased corner radius
                    .shadow(radius: 4)
                    .padding(.horizontal, 20) // Adjusted horizontal padding

                    // MARK: - Journal and Today's Quote Cards
                    HStack(spacing: 15) { // Increased spacing between cards
                        // Journal Card (Editable)
                        VStack(alignment: .leading) {
                            Text("Journal")
                                .font(.system(size: 18)) // Slightly enlarged font size
                                .fontWeight(.semibold)
                                .foregroundColor(.darkGreen)
                            // TextEditor for editable journal entry
                            TextEditor(text: $journalText)
                                .font(.system(size: 14)) // Adjusted font size for text editor
                                .foregroundColor(.gray)
                                .scrollContentBackground(.hidden) // Hide default background
                                .background(Color.clear) // Make TextEditor background clear
                                .frame(minHeight: 80) // Ensure enough space for editing
                        }
                        .padding(18) // Increased padding for larger block
                        .frame(maxWidth: .infinity, minHeight: 150) // Increased minHeight
                        .background(Color.secondaryYellow)
                        .cornerRadius(20) // Slightly increased corner radius
                        .shadow(radius: 4)

                        // Today's Quote Card
                        VStack(alignment: .leading) {
                            Text("Today's Quote")
                                .font(.system(size: 18)) // Slightly enlarged font size
                                .fontWeight(.semibold)
                                .foregroundColor(.darkGreen)
                            Spacer()
                            Text("\"If you can dream it, you can do it.\"")
                                .font(.system(size: 14)) // Slightly enlarged font size
                                .italic()
                                .foregroundColor(.gray)
                            Text("-Walt Disney")
                                .font(.system(size: 12)) // Slightly enlarged font size
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding(18) // Increased padding for larger block
                        .frame(maxWidth: .infinity, minHeight: 150) // Increased minHeight
                        .background(Color.secondaryYellow)
                        .cornerRadius(20) // Slightly increased corner radius
                        .shadow(radius: 4)
                    }
                    .padding(.horizontal, 20) // Adjusted horizontal padding
                    .padding(.bottom, 90) // Ensure enough space for the bottom nav bar
                }
                .frame(maxWidth: .infinity) // Ensure VStack takes full width
                .background(Color.secondaryYellow.ignoresSafeArea()) // Set background for the entire scrollable area
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure ScrollView takes full screen

            // MARK: - Bottom Navigation Bar
            VStack {
                Divider()
                    .background(Color.darkGreen.opacity(0.3))
                    .padding(.horizontal, -20) // Extend divider full width

                HStack {
                    Spacer()
                    TabButton(iconName: "location.fill", label: "Location", selectedTab: $selectedTab)
                    Spacer()
                    TabButton(iconName: "rosette", label: "Badge", selectedTab: $selectedTab)
                    Spacer()
                    TabButton(iconName: "house.fill", label: "Home", selectedTab: $selectedTab)
                    Spacer()
                    TabButton(iconName: "hand.raised.fill", label: "Action", selectedTab: $selectedTab)
                    Spacer()
                    TabButton(iconName: "person.fill", label: "Profile", selectedTab: $selectedTab)
                    Spacer()
                }
                .padding(.vertical, 10) // Slightly increased vertical padding
                .background(Color.secondaryYellow)
                .cornerRadius(20)
                .shadow(radius: 5)
            }
            .padding(.bottom, 0)
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: setupTimer)
        .onDisappear(perform: cancelTimer)
    }

    // MARK: - Timer Setup and Logic
    private func setupTimer() {
        let now = Date()
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: now)!
        let midnight = calendar.startOfDay(for: tomorrow)
        remainingTime = midnight.timeIntervalSince(now)

        if remainingTime < 0 {
            remainingTime = 0
        }

        cancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if remainingTime > 0 {
                    remainingTime -= 1
                } else {
                    remainingTime = 24 * 60 * 60
                    print("Daily Quest time reset!")
                }
            }
    }

    private func cancelTimer() {
        cancellable?.cancel()
        cancellable = nil
    }
}

// MARK: - TabButton (Helper View for Bottom Navigation Bar Items)
struct TabButton: View {
    let iconName: String
    let label: String
    @Binding var selectedTab: String

    var body: some View {
        Button(action: {
            selectedTab = label
            print("\(label) tab tapped")
        }) {
            VStack {
                Image(systemName: iconName)
                    .font(.title2)
                Text(label)
                    .font(.caption2)
            }
        }
        .foregroundColor(selectedTab == label ? .primaryOrange : .darkGreen)
        .animation(.easeOut, value: selectedTab)
    }
}

// MARK: - Preview Provider
struct HomeTab_Previews: PreviewProvider {
    static var previews: some View {
        HomeTab()
    }
}
