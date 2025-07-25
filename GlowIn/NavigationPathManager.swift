//
//  NavigationPathManager.swift
//  GlowIn
//
//  Created by YourName on 7/16/25.
//  (Adjust date and name)
//

import SwiftUI

// This class manages the navigation path for the entire app.
// It should be an EnvironmentObject.
class NavigationPathManager: ObservableObject {
    @Published var path = NavigationPath()
}
