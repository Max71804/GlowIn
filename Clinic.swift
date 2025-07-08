//
//  Clinic.swift
//  GlowIn
//
//  Created by SandboxLab on 7/7/25.
//

import Foundation
import CoreLocation // Needed for CLLocationCoordinate2D

// MARK: - Data Model for Clinics
struct Clinic: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
