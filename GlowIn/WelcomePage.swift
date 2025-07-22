//
//  WelcomePage.swift
//  GlowIn
//
//  Created by SandboxLab on 7/7/25.
//

import SwiftUI
import MapKit

struct WelcomePage: View {
    @EnvironmentObject var navigationPath: NavigationPathManager

    // State variables to control opacity for fade-in effect
    @State private var logoOpacity: Double = 0.0
    @State private var text1Opacity: Double = 0.0
    @State private var text2Opacity: Double = 0.0

    var body: some View {
        ZStack {
            // Background Color
            Color(red: 0.96, green: 0.95, blue: 0.88) // Light beige background
                .edgesIgnoringSafeArea(.all)

            VStack {
                // Top "GlöwIn" Text (This is static, no animation needed as per request)
                Text("GlöwIn")
                    .font(.custom("Inter-Bold", size: 30)) // Assuming a custom font, adjust as needed
                    .foregroundColor(Color(red: 0.25, green: 0.35, blue: 0.20)) // Dark green text
                    .padding(.top, 50)

                Spacer()

                // Central Image (the one with the arch, sun, and waves) - Fades in first
                Image("arch") // Make sure this image is in your Assets.xcassets
                    .resizable() // Make the image resizable
                    .aspectRatio(contentMode: .fit) // Maintain aspect ratio, fit within bounds
                    .frame(width: 300, height: 400) // Adjust the frame size as needed to match the original arch size
                    .padding(.bottom, 50) // Keep the original padding for spacing
                    .opacity(logoOpacity) // Apply opacity
                    .animation(.easeIn(duration: 1.0), value: logoOpacity) // Animation for logo

                Spacer()

                // "Ready to glow into who you are?" Text - Fades in second
                VStack(alignment: .leading) {
                    Text("Ready to glow into")
                    Text("who you are?")
                }
                .font(.custom("Inter-SemiBold", size: 36)) // Adjust font and size
                .foregroundColor(Color(red: 0.94, green: 0.45, blue: 0.24)) // Orange text
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 40)
                .padding(.bottom, 5)
                .opacity(text1Opacity) // Apply opacity
                .animation(.easeIn(duration: 1.0).delay(1.0), value: text1Opacity) // Animation for text 1 (after logo)

                // "you're inner self is already blinding!" Text - Fades in third
                VStack(alignment: .leading) {
                    Text("Your inner self is already blinding!")
                    Text("Let's shine")
                }
                .font(.custom("Inter-Regular", size: 16)) // Adjust font and size
                .foregroundColor(Color(red: 0.25, green: 0.35, blue: 0.20)) // Dark green text
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
                .opacity(text2Opacity) // Apply opacity
                .animation(.easeIn(duration: 1.0).delay(2.0), value: text2Opacity) // Animation for text 2 (after text 1)

                // Bottom Buttons
                HStack {
                    Button(action: {
                        // Action for Skip button: Navigate directly to ProfileView
                        navigationPath.navigate(to: "ProfileView")
                        print("Skip tapped, navigating to Profile View")
                    }) {
                        Text("Skip")
                            .font(.custom("Inter-SemiBold", size: 18))
                            .foregroundColor(Color(red: 0.25, green: 0.35, blue: 0.20)) // Dark green text
                            .padding(.leading, 40)
                    }

                    Spacer()

                    Button(action: {
                        // Action for Next button: Navigate to LoginPagever1
                        navigationPath.navigate(to: "LoginPagever1")
                        print("Next tapped, navigating to Login Page")
                    }) {
                        Text("Next")
                            .font(.custom("Inter-SemiBold", size: 20))
                            .foregroundColor(.white)
                            .padding(.vertical, 15)
                            .padding(.horizontal, 40)
                            .background(Color(red: 0.25, green: 0.35, blue: 0.20)) // Dark green background
                            .cornerRadius(30)
                    }
                    .padding(.trailing, 30)
                }
                .padding(.bottom, 20)
            }
            // REMOVED: .navigationDestination - this is now handled centrally in your App file
        }
        .onAppear {
            // Trigger animations when the view appears
            // The logo animates first
            logoOpacity = 1.0

            // Text 1 animates after a 1-second delay, leveraging the animation on the view
            text1Opacity = 1.0

            // Text 2 animates after a 2-second delay, leveraging the animation on the view
            text2Opacity = 1.0
        }
    }
}

// MARK: - Preview Provider
struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WelcomePage()
                .environmentObject(NavigationPathManager()) // Provide the environment object for preview
        }
    }
}
