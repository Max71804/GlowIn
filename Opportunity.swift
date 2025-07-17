//
//  Opportunity.swift
//  GlowIn
//
//  Created by Max on 7/13/25.
//  (Adjust date and name)
//

import Foundation

struct Opportunity: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let description: String
    let websiteURL: String? // Optional URL for more info

    // Conformance to Hashable for NavigationStack
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Opportunity, rhs: Opportunity) -> Bool {
        lhs.id == rhs.id
    }
}
