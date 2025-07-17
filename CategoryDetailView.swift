//
//  CategoryDetailView.swift
//  GlowIn
//
//  Created on 7/13/25.
//  (Adjust date and name)
//

import SwiftUI

struct CategoryDetailView: View {
    let categoryName: String // The category selected (e.g., "Hunger & Homelessness")
    let categoryIcon: String // The icon for the category (e.g., "bowl.fill")

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navigationPath: NavigationPathManager

    // Define custom colors
    let lightBeige = Color(red: 0.96, green: 0.95, blue: 0.88) // #F5F3E1
    let darkGreen = Color(red: 54/255, green: 79/255, blue: 35/255) // #364F23
    let orange = Color(red: 255/255, green: 93/255, blue: 0/255) // #FF5D00
    let trophyOrange = Color(red: 0.94, green: 0.45, blue: 0.24) // #EF733D

    // Mock data for opportunities based on category
    // In a real app, this would come from a database or API
    var opportunities: [Opportunity] {
        switch categoryName {
        case "Hunger & Homelessness":
            return [
                Opportunity(name: "Greater Chicago Food Depository",
                            description: "repack food, assist in distribution centers.",
                            websiteURL: "https://www.chicagofooddepository.org"),
                Opportunity(name: "Blessings in a Backpack",
                            description: "pack weekend food for food-insecure children.",
                            websiteURL: "https://www.blessingsinabackpack.org"),
                Opportunity(name: "The Love Fridge Chicago",
                            description: "stock and maintain community fridges across the city.",
                            websiteURL: "https://www.thelovefridge.com")
            ]
        case "Environment & Conservation":
            return [
                Opportunity(name: "Friends of the Chicago River",
                            description: "participate in river cleanups and restoration projects.",
                            websiteURL: "https://www.chicagoriver.org"),
                Opportunity(name: "Shedd Aquarium Action Volunteers",
                            description: "support conservation efforts and public education.",
                            websiteURL: "https://www.sheddaquarium.org/action/volunteer"),
                Opportunity(name: "Chicago Botanic Garden",
                            description: "assist with garden maintenance and educational programs.",
                            websiteURL: "https://www.chicagobotanic.org/volunteer")
            ]
        case "Education & Youth":
            return [
                Opportunity(name: "Chicago Public Library",
                            description: "tutor students, assist with programs, or organize books.",
                            websiteURL: "https://www.chipublib.org/volunteer"),
                Opportunity(name: "Boys & Girls Clubs of Chicago",
                            description: "mentor youth, assist with after-school programs.",
                            websiteURL: "https://bgcc.org/volunteer"),
                Opportunity(name: "Reading Partners Chicago",
                            description: "provide one-on-one literacy tutoring to elementary students.",
                            websiteURL: "https://readingpartners.org/location/chicago")
            ]
        case "Animal Welfare":
            return [
                Opportunity(name: "PAWS Chicago",
                            description: "care for shelter animals, assist with adoptions, or foster.",
                            websiteURL: "https://www.pawschicago.org/how-to-help/volunteer"),
                Opportunity(name: "Anti-Cruelty Society",
                            description: "walk dogs, socialize cats, or help with events.",
                            websiteURL: "https://anticruelty.org/volunteer"),
                Opportunity(name: "Tree House Humane Society",
                            description: "support cat welfare through various volunteer roles.",
                            websiteURL: "https://www.treehouseanimals.org/volunteer")
            ]
        case "Senior Support & Healthcare":
            return [
                Opportunity(name: "Meals on Wheels Chicago",
                            description: "deliver nutritious meals to homebound seniors.",
                            websiteURL: "https://www.mealsonwheelschicago.org/volunteer"),
                Opportunity(name: "Rush University Medical Center",
                            description: "assist patients, visitors, and staff in various departments.",
                            websiteURL: "https://www.rush.edu/volunteer"),
                Opportunity(name: "Catholic Charities Chicago",
                            description: "provide companionship and support to seniors.",
                            websiteURL: "https://www.catholiccharities.net/volunteer")
            ]
        case "Mental Health":
            return [
                Opportunity(name: "NAMI Chicago",
                            description: "support individuals and families affected by mental illness.",
                            websiteURL: "https://www.namichicago.org/get-involved/volunteer"),
                Opportunity(name: "Crisis Text Line",
                            description: "become a crisis counselor and provide support via text.",
                            websiteURL: "https://www.crisistextline.org/volunteer"),
                Opportunity(name: "Erie Family Health Centers",
                            description: "assist with community health programs and outreach.",
                            websiteURL: "https://www.eriefamilyhealth.org/get-involved/volunteer")
            ]
        default:
            return []
        }
    }

    var body: some View {
        ZStack {
            lightBeige.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                // MARK: - Top Bar (Back Button and Category Icon/Title)
                HStack {
                    Button(action: {
                        dismiss() // Go back to the previous view (ActionView)
                        print("Back button tapped from CategoryDetailView")
                    }) {
                        Image(systemName: "arrow.backward")
                            .font(.title2)
                            .foregroundColor(darkGreen)
                            .padding(.leading, 20)
                    }
                    Spacer()
                }
                .padding(.top, 20)

                HStack(alignment: .center, spacing: 10) {
                    Image(systemName: categoryIcon) // Category specific icon
                        .font(.title)
                        .foregroundColor(darkGreen)
                    Text(categoryName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(darkGreen)
                }
                .padding(.leading, 20)
                .padding(.bottom, 10)

                // MARK: - List of Opportunities
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(opportunities) { opportunity in
                            OpportunityRow(opportunity: opportunity)
                        }
                    }
                    .padding(.horizontal, 20)
                }

                Spacer() // Pushes content up

                // MARK: - Bottom Navigation Bar (replicated for consistency)
                // Note: Navigation from here would typically pop to root or handle tab switching
                VStack {
                    Divider()
                        .background(darkGreen.opacity(0.3))
                        .padding(.horizontal, -20)

                    HStack {
                        Spacer()
                        // Location Icon
                        Button(action: {
                            navigationPath.path = NavigationPath() // Corrected: Clear path
                            navigationPath.path.append("LocationView")
                            print("Location tab tapped from CategoryDetailView")
                        }) {
                            VStack {
                                Image(systemName: "location.fill")
                                    .font(.title2)
                                Text("Location")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Location" ? trophyOrange : darkGreen)
                        Spacer()

                        // Badge Icon
                        Button(action: {
                            navigationPath.path = NavigationPath() // Corrected: Clear path
                            navigationPath.path.append("AchievementsView")
                            print("Badge tab tapped from CategoryDetailView")
                        }) {
                            VStack {
                                Image(systemName: "rosette")
                                    .font(.title2)
                                Text("Badge")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Badge" ? trophyOrange : darkGreen)
                        Spacer()

                        // Home Icon
                        Button(action: {
                            navigationPath.path = NavigationPath() // Corrected: Clear path
                            navigationPath.path.append("HomeView")
                            print("Home tab tapped from CategoryDetailView")
                        }) {
                            VStack {
                                Image(systemName: "house.fill")
                                    .font(.title2)
                                Text("Home")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Home" ? trophyOrange : darkGreen)
                        Spacer()

                        // Action Icon (This is within the Action flow, so keep it highlighted)
                        Button(action: {
                            navigationPath.path = NavigationPath() // Corrected: Clear path
                            navigationPath.path.append("ActionView") // Go back to the main ActionView
                            print("Action tab tapped from CategoryDetailView")
                        }) {
                            VStack {
                                Image(systemName: "hand.raised.fill")
                                    .font(.title2)
                                Text("Action")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Action" ? trophyOrange : darkGreen) // Highlighted
                        Spacer()

                        // Profile Icon
                        Button(action: {
                            navigationPath.path = NavigationPath() // Corrected: Clear path
                            navigationPath.path.append("ProfileView")
                            print("Profile tab tapped from CategoryDetailView")
                        }) {
                            VStack {
                                Image(systemName: "person.fill")
                                    .font(.title2)
                                Text("Profile")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Profile" ? trophyOrange : darkGreen)
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .background(lightBeige)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                }
                .padding(.bottom, 0)
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    // State for the bottom navigation bar selection, needed within this view
    @State private var selectedTab: String = "Action" // Default to Action for this view
}

// MARK: - OpportunityRow Sub-View (No changes needed here)
struct OpportunityRow: View {
    let opportunity: Opportunity

    let darkGreen = Color(red: 54/255, green: 79/255, blue: 35/255)
    let lightGreen = Color(red: 198/255, green: 228/255, blue: 139/255)

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(opportunity.name)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(darkGreen)
            Text(opportunity.description)
                .font(.subheadline)
                .foregroundColor(darkGreen.opacity(0.8))

            if let urlString = opportunity.websiteURL, let url = URL(string: urlString) {
                Link("Learn More", destination: url)
                    .font(.caption)
                    .foregroundColor(.blue) // Standard link color
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(lightGreen.opacity(0.7)) // Slightly transparent light green
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

// MARK: - Preview Provider (No changes needed here)
struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CategoryDetailView(categoryName: "Hunger & Homelessness", categoryIcon: "bowl.fill")
                .environmentObject(NavigationPathManager())
        }
    }
}
