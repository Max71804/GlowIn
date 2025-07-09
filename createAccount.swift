//
//  ContentView.swift
//  loginDemo
//
//  Created by Hooriya Kazmi on 6/30/25.
//
import SwiftUI

struct create: View {
    @State var username = ""
    @State var password = ""
    @State var confirmPassword = ""
    
    let darkGreen = Color(red: 54/255, green: 79/255, blue: 35/255) // #364F23
    let orange = Color(red: 255/255, green: 93/255, blue: 0/255)
    let cream = Color(red: 255/255, green: 239/255, blue: 193/255)
    let softOrange = Color(red: 255/255, green: 202/255, blue: 123/255)

    var body: some View {
        ZStack {
            cream.ignoresSafeArea()
            
            VStack {
                Text("Create Account")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(orange)
                
                Text("Welcome! Ready to get your \nglow on?")
                    .foregroundColor(darkGreen)
                    .padding(.top, 50)
                    .multilineTextAlignment(.center)
                
                // Email
                TextField("Email", text: $username)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(orange, lineWidth: 2))
                    .cornerRadius(10)
                    .padding(.top, 60)
                    .foregroundColor(darkGreen)

                // Password
                SecureField("Password", text: $confirmPassword)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(orange, lineWidth: 2))
                    .cornerRadius(10)
                    .padding(.top, 30)
                    .foregroundColor(darkGreen)

                // Confirm Password
                SecureField("Confirm Password", text: $password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(orange, lineWidth: 2))
                    .cornerRadius(10)
                    .padding(.top, 30)
                    .foregroundColor(darkGreen)

                // Sign up Button
                Button("Sign up") {
                    // Handle sign up
                }
                .frame(width: 300, height: 50)
                .foregroundColor(.white)
                .background(darkGreen)
                .cornerRadius(40)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                .padding(.top, 30)

                // Already have an account
                Button("Already have an account?") {
                    // Navigate back
                }
                .foregroundColor(darkGreen)
                .padding(.top, 8)
                .font(.caption)

                // Continue with
                Text("or continue with")
                    .foregroundColor(darkGreen)
                    .padding(.top, 50)

                // Login options
                HStack(spacing: 16) {
                    ForEach(["apple", "facebook", "google"], id: \.self) { icon in
                        Button {
                            print("\(icon.capitalized) login tapped")
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(softOrange)
                                    .frame(width: 40, height: 41)
                                Image(icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    create()
}
