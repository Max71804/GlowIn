//
//  ActionView.swift
//  GlowIn
//
//  Created by Max on 7/13/25.
//  (Adjust date and name)
//

import SwiftUI

struct ActionView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navigationPath: NavigationPathManager

    @State private var selectedActionTab: String = "Volunteering" // State to switch between Volunteering and Donate

    // Define custom colors based on the app's theme
    let lightBeige = Color(red: 0.96, green: 0.95, blue: 0.88) // #F5F3E1
    let darkGreen = Color(red: 54/255, green: 79/255, blue: 35/255) // #364F23
    let orange = Color(red: 255/255, green: 93/255, blue: 0/255) // #FF5D00
    let softOrange = Color(red: 255/255, green: 202/255, blue: 123/255) // #FFCA7B
    let trophyOrange = Color(red: 0.94, green: 0.45, blue: 0.24) // #EF733D

    var body: some View {
        ZStack {
            lightBeige.ignoresSafeArea()

            VStack(spacing: 20) {
                // MARK: - Top Bar
                HStack {
                    Button(action: {
                        dismiss() // Go back to the previous view
                        print("Back button tapped from ActionView")
                    }) {
                        Image(systemName: "arrow.backward")
                            .font(.title2)
                            .foregroundColor(darkGreen)
                            .padding(.leading, 20)
                    }
                    Spacer()
                }
                .padding(.top, 20)

                // MARK: - "Feel Good" Title
                HStack {
                    Text("Feel Good")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(darkGreen)
                        .padding(.leading, 20)
                    Spacer()
                }

                // MARK: - Volunteering / Donate Segmented Control
                HStack(spacing: 20) {
                    Button(action: {
                        selectedActionTab = "Volunteering"
                    }) {
                        VStack(alignment: .leading) {
                            Text("Volunteering")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(selectedActionTab == "Volunteering" ? trophyOrange : darkGreen.opacity(0.6))
                            Circle()
                                .fill(selectedActionTab == "Volunteering" ? trophyOrange : .clear)
                                .frame(width: 6, height: 6)
                                .padding(.leading, 5)
                        }
                    }

                    Button(action: {
                        selectedActionTab = "Donate"
                    }) {
                        VStack(alignment: .leading) {
                            Text("Donate")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(selectedActionTab == "Donate" ? trophyOrange : darkGreen.opacity(0.6))
                            Circle()
                                .fill(selectedActionTab == "Donate" ? trophyOrange : .clear)
                                .frame(width: 6, height: 6)
                                .padding(.leading, 5)
                        }
                    }
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.bottom, 10)

                // MARK: - Content based on selected tab
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        if selectedActionTab == "Volunteering" {
                            VolunteeringContent()
                        } else {
                            DonateContent()
                        }
                    }
                    .padding(.horizontal, 20)
                }

                Spacer() // Pushes content up

                // MARK: - Bottom Navigation Bar (replicated from other views)
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
                            print("Location tab tapped")
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
                            print("Badge tab tapped")
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
                            print("Home tab tapped")
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

                        // Action Icon (Current Page)
                        Button(action: {
                            // Already on this page, keep it highlighted
                            selectedTab = "Action"
                            print("Action tab tapped (already on ActionView)")
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
                            print("Profile tab tapped")
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
            // Add CategoryDetailView as a navigation destination
            .navigationDestination(for: String.self) { viewID in
                // Using a switch statement for cleaner handling of multiple destinations
                switch viewID {
                case "Moodtracker":
                    moodTracker()
                case "AchievementsView":
                    WeeklyAchievementsView()
                case "LocationView":
                    LocationView()
                case "HomeView":
                    Text("Placeholder for HomeView")
                case "ActionView":
                    ActionView() // This should ideally not be navigated to from itself, but for completeness
                default:
                    // Handle specific category detail views
                    if let category = CategoryType(rawValue: viewID) {
                        // CategoryDetailView still uses iconName (SF Symbol)
                        CategoryDetailView(categoryName: category.rawValue, categoryIcon: category.iconName)
                    } else {
                        Text("Unknown Destination: \(viewID)")
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    // State for the bottom navigation bar selection, needed within this view
    @State private var selectedTab: String = "Action" // Default to Action for this view
}

// Enum to define categories and their image asset names
enum CategoryType: String, CaseIterable {
    case hungerHomelessness = "Hunger & Homelessness"
    case environmentConservation = "Environment & Conservation"
    case educationYouth = "Education & Youth"
    case animalWelfare = "Animal Welfare"
    case seniorSupportHealthcare = "Senior Support & Healthcare"
    case mentalHealth = "Mental Health"

    // Keep imageAssetName for custom images if needed elsewhere, but CategoryCard will use iconName
    var imageAssetName: String {
        switch self {
        case .hungerHomelessness: return "hunger_icon"
        case .environmentConservation: return "environment_icon"
        case .educationYouth: return "education_icon"
        case .animalWelfare: return "animal_icon"
        case .seniorSupportHealthcare: return "senior_icon"
        case .mentalHealth: return "mental_health_icon"
        }
    }
    // This property already provides SF Symbols
    var iconName: String {
        switch self {
        case .hungerHomelessness: return "bowl.fill"
        case .environmentConservation: return "leaf.fill"
        case .educationYouth: return "book.closed.fill"
        case .animalWelfare: return "pawprint.fill"
        case .seniorSupportHealthcare: return "face.smiling.fill"
        case .mentalHealth: return "brain.head.profile"
        }
    }
}

// MARK: - Volunteering Content Sub-View
struct VolunteeringContent: View {
    // This view will now receive navigationPath as an EnvironmentObject
    @EnvironmentObject var navigationPath: NavigationPathManager

    let darkGreen = Color(red: 54/255, green: 79/255, blue: 35/255)
    let lightGreen = Color(red: 198/255, green: 228/255, blue: 139/255) // #C6E48B

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Recent")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(darkGreen)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    // Hunger & Homelessness
                    // Now passing sfSymbolName to CategoryCard
                    CategoryCard(sfSymbolName: CategoryType.hungerHomelessness.iconName, text: CategoryType.hungerHomelessness.rawValue) { category in
                        navigationPath.path.append(category.rawValue)
                    }
                    // Environment & Conservation
                    CategoryCard(sfSymbolName: CategoryType.environmentConservation.iconName, text: CategoryType.environmentConservation.rawValue) { category in
                        navigationPath.path.append(category.rawValue)
                    }
                    // Education & Youth
                    CategoryCard(sfSymbolName: CategoryType.educationYouth.iconName, text: CategoryType.educationYouth.rawValue) { category in
                        navigationPath.path.append(category.rawValue)
                    }
                }
            }

            Text("More")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(darkGreen)
                .padding(.top, 10)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    // Animal Welfare
                    CategoryCard(sfSymbolName: CategoryType.animalWelfare.iconName, text: CategoryType.animalWelfare.rawValue) { category in
                        navigationPath.path.append(category.rawValue)
                    }
                    // Senior Support & Healthcare
                    CategoryCard(sfSymbolName: CategoryType.seniorSupportHealthcare.iconName, text: CategoryType.seniorSupportHealthcare.rawValue) { category in
                        navigationPath.path.append(category.rawValue)
                    }
                    // Mental Health
                    CategoryCard(sfSymbolName: CategoryType.mentalHealth.iconName, text: CategoryType.mentalHealth.rawValue) { category in
                        navigationPath.path.append(category.rawValue)
                    }
                }
            }
        }
    }
}

// MARK: - Donate Content Sub-View
struct DonateContent: View {
    // This view will now receive navigationPath as an EnvironmentObject
    @EnvironmentObject var navigationPath: NavigationPathManager

    let darkGreen = Color(red: 54/255, green: 79/255, blue: 35/255)
    let lightGreen = Color(red: 198/255, green: 228/255, blue: 139/255) // #C6E48B

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Recent")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(darkGreen)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    // Greater Chicago Food Depositor
                    OrganizationCard(sfSymbolName: "fork.knife", text: "Greater\nChicago Food\nDepositor") {
                        print("Tapped Greater Chicago Food Depositor for donation")
                    }
                    // Cradles to Crayons
                    OrganizationCard(sfSymbolName: "tshirt.fill", text: "Cradles to\nCrayons") {
                        print("Tapped Cradles to Crayons for donation")
                    }
                    // CAIR (example)
                    OrganizationCard(sfSymbolName: "building.columns.fill", text: "CAIR") {
                        print("Tapped CAIR for donation")
                    }
                }
            }

            Text("More")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(darkGreen)
                .padding(.top, 10)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    // RefugeeOne
                    OrganizationCard(sfSymbolName: "person.3.fill", text: "RefugeeOne") {
                        print("Tapped RefugeeOne for donation")
                    }
                    // Care for Real
                    OrganizationCard(sfSymbolName: "heart.text.square.fill", text: "Care for Real") {
                        print("Tapped Care for Real for donation")
                    }
                    // Nourish Hope (example)
                    OrganizationCard(sfSymbolName: "leaf.fill", text: "Nourish\nHope") {
                        print("Tapped Nourish Hope for donation")
                    }
                }
            }
        }
    }
}

// MARK: - Helper Views for Category and Organization Cards

struct CategoryCard: View {
    let sfSymbolName: String // Now explicitly takes an SF Symbol name
    let text: String
    let action: (CategoryType) -> Void // Closure to perform action on tap

    let darkGreen = Color(red: 54/255, green: 79/255, blue: 35/255)
    let lightGreen = Color(red: 198/255, green: 228/255, blue: 139/255) // #C6E48B

    // New initializer to match the updated properties
    init(sfSymbolName: String, text: String, action: @escaping (CategoryType) -> Void) {
        self.sfSymbolName = sfSymbolName
        self.text = text
        // Find the CategoryType from the text to pass to the action closure
        // This assumes text matches CategoryType.rawValue
        self.action = { categoryType in
            if let foundCategory = CategoryType(rawValue: text) {
                action(foundCategory)
            }
        }
    }

    var body: some View {
        Button(action: {
            // Reconstruct CategoryType for the action if needed, or pass text directly
            // For this specific action, we need to pass the CategoryType object
            if let category = CategoryType(rawValue: text) {
                action(category)
            }
        }) {
            VStack(spacing: 10) {
                // Use SF Symbol here
                Image(systemName: sfSymbolName) // Changed to use sfSymbolName
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60) // Consistent size
                    .foregroundColor(darkGreen) // Apply tint for SF Symbols
                Text(text) // Use the text passed in
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(darkGreen)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 120, height: 120)
            .background(lightGreen)
            .cornerRadius(15)
            .shadow(radius: 3)
            .overlay(
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(darkGreen)
                            .padding([.top, .trailing], 8)
                    }
                    Spacer()
                }
            )
        }
        .buttonStyle(PlainButtonStyle()) // To remove default button styling
    }
}

struct OrganizationCard: View {
    // Made imageName optional and added sfSymbolName
    let imageName: String? // For specific organization logos (optional now)
    let sfSymbolName: String? // For generic SF Symbols (new)
    let text: String
    let action: () -> Void // Closure to perform action on tap

    let darkGreen = Color(red: 54/255, green: 79/255, blue: 35/255)
    let lightGreen = Color(red: 198/255, green: 228/255, blue: 139/255)

    // Initializer to allow passing either sfSymbolName or imageName
    init(imageName: String? = nil, sfSymbolName: String? = nil, text: String, action: @escaping () -> Void) {
        self.imageName = imageName
        self.sfSymbolName = sfSymbolName
        self.text = text
        self.action = action
    }

    var body: some View {
        Button(action: {
            action() // Execute the action
        }) {
            VStack(spacing: 10) {
                // Conditional rendering: prefer SF Symbol if provided, otherwise use custom image asset
                if let sfSymbolName = sfSymbolName {
                    Image(systemName: sfSymbolName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60) // Match CategoryCard icon size
                        .foregroundColor(darkGreen) // Apply tint for SF Symbols
                } else if let imageName = imageName {
                    Image(imageName) // Organization logo
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60) // Match CategoryCard icon size
                        .foregroundColor(darkGreen) // Apply tint if it's a template image
                } else {
                    // Fallback if neither is provided (e.g., a placeholder)
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 60, height: 60)
                        .cornerRadius(10)
                }

                Text(text)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(darkGreen) // Text color remains dark green
                    .multilineTextAlignment(.center)
            }
            .frame(width: 120, height: 120)
            .background(lightGreen) // Use lightGreen background as in screenshot
            .cornerRadius(15)
            .shadow(radius: 3)
            .overlay(
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(darkGreen)
                            .padding([.top, .trailing], 8)
                    }
                    Spacer()
                }
            )
        }
        .buttonStyle(PlainButtonStyle()) // To remove default button styling
    }
}

// MARK: - Preview Provider
struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ActionView()
                .environmentObject(NavigationPathManager())
        }
    }
}
