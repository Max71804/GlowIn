//
//  SocialLoginVerificationView.swift
//  GlowIn
//
//  Created by Max on 7/10/25.
//  (Adjust date and name)
//

import SwiftUI

struct SocialLoginVerificationView: View {
    let loginType: String // e.g., "Apple", "Google", "Facebook"
    var onVerificationComplete: () -> Void // Callback to dismiss and navigate

    @State private var isLoading = true

    var body: some View {
        ZStack {
            Color(.systemBackground) // Or your app's background color
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2.0)
                        .padding()
                    Text("Verifying with \(loginType)...")
                        .font(.title2)
                        .foregroundColor(.gray)
                } else {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.green)
                    Text("\(loginType) Verification Successful!")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 54/255, green: 79/255, blue: 35/255)) // Dark Green

                    Button("Continue") {
                        onVerificationComplete() // Trigger the callback to dismiss and navigate
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 30)
                    .background(Color(red: 54/255, green: 79/255, blue: 35/255)) // Dark Green
                    .cornerRadius(25)
                    .shadow(radius: 5)
                }
                Spacer()
            }
        }
        .onAppear {
            // Simulate a network request or verification process
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 2-second delay
                isLoading = false
            }
        }
    }
}

// MARK: - Preview Provider
struct SocialLoginVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        SocialLoginVerificationView(loginType: "Apple") {
            print("Verification complete callback in preview")
        }
    }
}
