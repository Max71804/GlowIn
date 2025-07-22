//
//  Moodtracker.swift
//  GlowIn
//
//  Created by SandboxLab on 7/9/25.
//

import SwiftUI

struct moodTracker: View {
    @Environment(\.dismiss) var dismiss // For navigating back
    @EnvironmentObject var navigationPath: NavigationPathManager // Added for navigation
    @EnvironmentObject var imagedisplay: moodModel


    var body: some View {
        let cream = Color(red: 255/255, green: 239/255, blue: 193/255)

        ZStack {
            cream
                .ignoresSafeArea()

            VStack {
                HStack {
                    // Back button for Moodtracker (removed as per flow, but keeping for reference if needed)
                    // If you want a back button here, you'd dismiss()
                    Spacer() // Pushes content to center
                }
                .padding(.top, 20)

                Spacer() // Pushes content towards center

                HStack {
                    Button(action: {
                        print("Sad face tapped")
                        imagedisplay.mood = "sad"
                    }) {
                        VStack {
                            Image("sad") // Ensure you have "sad" image asset in Assets.xcassets
                                .resizable()
                                .frame(width: 120, height: 200)
                                .padding(.bottom, -50)
                            Text("sad")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        .padding(.trailing, 20)
                    }

                    Button(action: {
                        print("Not good face tapped")
                        imagedisplay.mood = "notGood"
                    }) {
                        VStack {
                            Image("notGood") // Ensure you have "notGood" image asset in Assets.xcassets
                                .resizable()
                                .frame(width: 100, height: 140)
                                .padding(.bottom, -40)
                            Text("not good")
                                .font(.headline)
                                .foregroundColor(.black)

                        }

                    }
                }

                HStack {
                    Button(action: {
                        print("Okay face tapped")
                        imagedisplay.mood = "okay"
                    }) {
                        VStack {
                            Image("okay") // Ensure you have "okay" image asset in Assets.xcassets
                                .resizable()
                                .frame(width: 140, height: 150)
                                .padding(.bottom, -40)
                            Text("okay")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        .padding()
                    }

                    Button(action: {
                        print("Good face tapped")
                        imagedisplay.mood = "good"
                    }) {
                        VStack {
                            Image("good") // Ensure you have "good" image asset in Assets.xcassets
                                .resizable()
                                .frame(width: 120, height: 140)
                                .padding(.bottom, -40)
                            Text("good")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        .padding()

                    }
                }

                Button(action: {
                    print("Happy face tapped")
                    imagedisplay.mood = "happy"
                }) {
                    VStack {
                        Image("happy") // Ensure you have "happy" image asset in Assets.xcassets
                            .resizable()
                            .frame(width: 120, height: 170)
                            .padding(.bottom, -40)
                        Text("happy")
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                }

                Text("How are you feeling \ntoday?")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 54/255, green: 79/255, blue: 35/255))
                    .padding(.top, 50)
                    .multilineTextAlignment(.center)
                Text("select an emoji that most closely aligns\nwith your mood ")
                    .font(.caption)
                    .foregroundColor(Color(red: 255/255, green: 93/255, blue: 0/255))
                    .padding(.bottom, 50)
                    .multilineTextAlignment(.center)

                Button(action: {
                    print("Done button tapped, navigating to ProfileView")
                    navigationPath.path = NavigationPath() // Clear path to start fresh
                    navigationPath.path.append("ProfileView") // Navigate to ProfileView
                }) {
                    Text("Done")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 5)
                        .background(Color(red: 54/255, green: 79/255, blue: 35/255))
                        .cornerRadius(12)
                }

                Spacer() // Pushes content towards center
            }
        }
        .onAppear { // <--- ADDED THIS BLOCK
            print("+++ Moodtracker: View has appeared! +++")
        }
        .navigationBarBackButtonHidden(true) // Hide default back button
    }
}

// MARK: - Preview Provider
struct moodTracker_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            moodTracker()
                .environmentObject(NavigationPathManager()) // Provide environment object for preview
        }
    }
}
