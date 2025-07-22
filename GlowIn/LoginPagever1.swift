import SwiftUI

struct login: View {
    @State var username = ""
    @State var password = ""
    @State private var showingSocialLoginSheet = false
    @State private var socialLoginType: String = ""

    @EnvironmentObject var navigationPath: NavigationPathManager // Custom path manager for NavigationStack

    let orange = Color(red: 255/255, green: 93/255, blue: 0/255)       // #FF5D00
    let cream = Color(red: 0.96, green: 0.95, blue: 0.88)   
    let darkGreen = Color(red: 54/255, green: 79/255, blue: 35/255)    // #364F23
    let softOrange = Color(red: 255/255, green: 202/255, blue: 123/255)

    var body: some View {
        ZStack {
            cream
                .ignoresSafeArea()

            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(orange)
                Text("Welcome back! You've been\nmissed")
                    .foregroundColor(darkGreen)
                    .padding(.top, 50)
                    .multilineTextAlignment(.center)

                // Email
                TextField("Email", text: $username)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .foregroundColor(darkGreen)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(orange, lineWidth: 2)
                    )
                    .cornerRadius(10)
                    .padding(.top, 60)

                // Password
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .foregroundColor(darkGreen)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(orange, lineWidth: 2)
                    )
                    .cornerRadius(10)
                    .padding(.horizontal, 32)
                    .padding(.top, 30)

                // Forgot password
                HStack {
                    Spacer()
                    Button("Forgot your password?") {
                        print("Forgot password tapped")
                        // Implement password recovery flow here
                    }
                    .font(.caption)
                    .foregroundColor(darkGreen)
                    .padding(.trailing, 32)
                }

                // Sign in Button
                Button("Sign in") {
                    // Handle sign in logic
                    print("--- Sign in button tapped. Attempting to navigate to Moodtracker. ---")
                    navigationPath.path.append("Moodtracker") // Navigate to Moodtracker
                }
                .frame(width: 300, height: 50)
                .foregroundColor(.white)
                .background(darkGreen)
                .cornerRadius(40)
                .padding(.horizontal, 32)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                .padding(.top, 30)

                // Create new account button
                Button("create new account") {
                    print("Create new account tapped, navigating to Create Account View")
                    navigationPath.path.append("CreateAccountView")
                }
                .foregroundColor(darkGreen)
                .padding(.top, 8)

                // Continue with
                Text("or continue with")
                    .foregroundColor(darkGreen)
                    .padding(.top, 50)

                HStack(spacing: 16) {
                    // Apple login
                    Button(action: {
                        socialLoginType = "Apple"
                        showingSocialLoginSheet = true
                        print("Apple login tapped")
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(softOrange)
                                .frame(width: 40, height: 41)
                            Image("apple") // Ensure you have "apple" image asset
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                    }
                    // Facebook login
                    Button(action: {
                        socialLoginType = "Facebook"
                        showingSocialLoginSheet = true
                        print("Facebook login tapped")
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(softOrange)
                                .frame(width: 40, height: 41)
                            Image("facebook") // Ensure you have "facebook" image asset
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                    }
                    // Google login
                    Button(action: {
                        socialLoginType = "Google"
                        showingSocialLoginSheet = true
                        print("Google login tapped")
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(softOrange)
                                .frame(width: 40, height: 41)
                            Image("google") // Ensure you have "google" image asset
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                    }
                }
            }
            // Removed the .navigationDestination block from here as it's handled in GlowInApp.swift
            .fullScreenCover(isPresented: $showingSocialLoginSheet) {
                // Assuming SocialLoginVerificationView exists and handles its own dismissal
                SocialLoginVerificationView(loginType: socialLoginType) {
                    // Callback after social login "verification"
                    showingSocialLoginSheet = false // Dismiss the sheet
                    navigationPath.path.append("Moodtracker") // Navigate to Moodtracker after social login
                    print("Social login successful, navigating to Moodtracker")
                }
            }
        }
        .navigationBarBackButtonHidden(true) // Hide default back button
    }
}

// MARK: - Preview Provider
struct LoginPagever1_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            login()
                .environmentObject(NavigationPathManager()) // Provide the environment object for preview
        }
    }
}
