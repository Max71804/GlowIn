//
//  AchievementEvaluationView.swift
//  GlowIn
//
//  Created by YourName on 7/14/25.
//  (Adjust date and name)
//

import SwiftUI

struct AchievementEvaluationView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navigationPath: NavigationPathManager

    let completedQuestText: String // To display which quest was completed

    // Define custom colors based on the screenshot and app's theme
    let lightBeige = Color(red: 0.96, green: 0.95, blue: 0.88) // #F5F3E1
    let darkGreen = Color(red: 54/255, green: 79/255, blue: 35/255) // #364F23
    let orangeCard = Color(red: 240/255, green: 153/255, blue: 110/255) // #F0996E (top card color)
    let lightGreenCard = Color(red: 198/255, green: 228/255, blue: 139/255) // #C6E48B (bottom card color)
    let trophyOrange = Color(red: 0.94, green: 0.45, blue: 0.24) // #EF733D (for trophy/flame)

    var body: some View {
        ZStack {
            lightBeige.ignoresSafeArea()

            VStack(spacing: 20) {
                // MARK: - Top Spacer (to push content down)
                Spacer()

                // MARK: - Trophy Icon
                Image(systemName: "trophy.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .foregroundColor(trophyOrange) // Orange color for trophy
                    .shadow(radius: 5)
                    .offset(y: 40) // Overlap with the card below

                // MARK: - Evaluation Card
                VStack(spacing: 20) {
                    HStack {
                        Spacer()
                        Image(systemName: "flame.fill")
                            .foregroundColor(trophyOrange)
                        Text("6") // Streak count
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.trailing, 10)
                    }
                    .padding(.top, 10) // Space from top of card

                    Text("Yay!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white) // White text for "Yay!"
                        .padding(.top, -20) // Adjust for trophy overlap

                    Text("You completed the quest")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white) // White text for quest completion
                        .padding(.bottom, 20)

                    // Thumbs Up / Thumbs Down Buttons
                    HStack(spacing: 30) {
                        Button(action: {
                            print("Liked it!")
                            // Logic for "liked" feedback
                        }) {
                            VStack {
                                Image(systemName: "hand.thumbsup.fill") // SF Symbol for thumbs up
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                                Text("I liked it!")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(darkGreen) // Dark green background
                            .clipShape(Circle())
                            .shadow(radius: 3)
                        }

                        Button(action: {
                            print("Not for me")
                            // Logic for "disliked" feedback
                        }) {
                            VStack {
                                Image(systemName: "hand.thumbsdown.fill") // SF Symbol for thumbs down
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                                Text("not for me")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(darkGreen) // Dark green background
                            .clipShape(Circle())
                            .shadow(radius: 3)
                        }
                    }
                    .padding(.bottom, 30) // Space before the orange character

                    // Orange Character and Done Button
                    HStack {
                        Image("orange_character") // Assuming you have this image asset
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .offset(y: 10) // Adjust position

                        Spacer()

                        Button(action: {
                            // Navigate back to AchievementsView or Home, or clear path
                            navigationPath.path = NavigationPath() // Clear path to go to root of NavigationStack
                            // Or if you want to go back to AchievementsView specifically:
                            // dismiss() // This would pop back one level
                            print("Done button tapped, navigating back to Achievements")
                        }) {
                            HStack {
                                Text("done")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(orangeCard) // Orange background
                            .cornerRadius(25)
                            .shadow(radius: 3)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20) // Space from bottom of card
                }
                .background(lightGreenCard) // Light green background for the main card
                .cornerRadius(25)
                .shadow(radius: 8)
                .padding(.horizontal, 30) // Horizontal padding for the card

                Spacer() // Push content up
            }
        }
        .navigationBarBackButtonHidden(true) // Hide default back button
    }
}

// MARK: - Preview Provider
struct AchievementEvaluationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AchievementEvaluationView(completedQuestText: "Smile at a Stranger")
                .environmentObject(NavigationPathManager())
        }
    }
}
