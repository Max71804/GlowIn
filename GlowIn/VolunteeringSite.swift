//
//  VolunteerSite.swift
//  GlowIn
//
//  Created by Max on 7/10/25.
//  (Adjust date and name)
//

import CoreLocation // Needed for CLLocationCoordinate2D
import Foundation // Needed for UUID

struct VolunteeringSite: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
