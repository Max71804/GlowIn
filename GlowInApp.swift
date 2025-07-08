//
//  GlowInApp.swift
//  GlowIn
//
//  Created by SandboxLab on 7/6/25.
//

import SwiftUI

@main
struct GlowInApp: App {
    init() {
        // Any app-wide setup, like Google Maps API key if you re-integrate it later
        // GMSServices.provideAPIKey("YOUR_API_KEY") // Uncomment and add your key if needed
    }

    var body: some Scene {
        WindowGroup {
            WelcomePage() // This should be your initial onboarding screen
        }
    }
}
