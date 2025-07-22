//
//  LocationView.swift
//  GlowIn
//
//  Created by SandboxLab on 7/6/25.
//

import SwiftUI
import MapKit // Import MapKit for the map view
import CoreLocation // For CLLocationCoordinate2D and CLLocationManager

// MARK: - IMPORTANT: Clinic struct definition HAS BEEN REMOVED from here.
// It should ONLY be defined ONCE in its own file: Clinic.swift
// If you see 'struct Clinic: Identifiable { ... }' below this line in your file, DELETE IT.
//
// struct Clinic: Identifiable {
//     let id = UUID()
//     let name: String
//     let coordinate: CLLocationCoordinate2D
// }

// MARK: - LocationView (Main Interface with Live Map and Toolbar)
struct LocationView: View {
    @State private var searchText: String = ""
    @State private var currentSheetHeight: CGFloat = UIScreen.main.bounds.height * 0.3 // Initial height of the sheet
    @State private var sheetDragOffset: CGFloat = 0
    @EnvironmentObject var navigationPath: NavigationPathManager

    let minSheetHeight: CGFloat = UIScreen.main.bounds.height * 0.3
    let maxSheetHeight: CGFloat = UIScreen.main.bounds.height * 0.85

    // Live-location publisher
    @StateObject private var loc = LocationManager()

    // Prototype volunteer locations (hard-coded)
    // Clinic is now accessed from Clinic.swift
    private let volunteerSites: [VolunteerSite] = [ // Changed from 'clinics' to 'volunteerSites'
        .init(name: "City Food Pantry", // Changed name
              coordinate: .init(latitude: 41.880, longitude: -87.629)),
        .init(name: "Community Hospital", // Changed name
              coordinate: .init(latitude: 41.877, longitude: -87.626)),
        .init(name: "Downtown Marathon Aid Station", // Changed name
              coordinate: .init(latitude: 41.879, longitude: -87.630))
    ]

    // Fallback "fake" location = downtown Chicago
    private let fallback = CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298)

    // Map camera position
    @State private var cameraPosition: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    ))

    // State to manage which tab is currently selected in the bottom bar
    @State private var selectedTab: String = "Location" // Default to Location tab for this view

    // New state to manage highlighted volunteer site on the map
    @State private var highlightedSiteId: UUID? = nil

    // Mock data for volunteering locations - Keep this as is if it's the list in the sheet
    let volunteeringLocations: [LocationItem] = [
        LocationItem(
            name: "The Giving Kitchen",
            rating: 4.9,
            reviewCount: 250,
            priceRange: "$", // Can be interpreted as "low cost" or "free" for volunteering context
            cuisine: "Non-profit",
            address: "123 Volunteer Way",
            openStatus: "Open",
            closesTime: "5PM",
            dineIn: false, // Changed from restaurant-specific to more general activity
            takeout: false,
            delivery: false,
            startingAt: nil, // Not relevant for volunteering directly
            imageName: "giving_kitchen"
        ),
        LocationItem(
            name: "Community Food Bank",
            rating: 4.8,
            reviewCount: 500,
            priceRange: "$",
            cuisine: "Charity",
            address: "456 Oak Avenue",
            openStatus: "Open",
            closesTime: "6PM",
            dineIn: false,
            takeout: false,
            delivery: false,
            startingAt: nil,
            imageName: "food_bank"
        ),
        LocationItem(
            name: "Local Animal Shelter", // New volunteer example
            rating: 4.7,
            reviewCount: 320,
            priceRange: "$",
            cuisine: "Animal Welfare",
            address: "789 Pet Lane",
            openStatus: "Open",
            closesTime: "4PM",
            dineIn: false,
            takeout: false,
            delivery: false,
            startingAt: nil,
            imageName: "animal_shelter" // You'll need to add this image asset
        ),
        LocationItem(
            name: "Park Cleanup Initiative", // New volunteer example
            rating: 4.5,
            reviewCount: 180,
            priceRange: "$",
            cuisine: "Environmental",
            address: "Green Valley Park",
            openStatus: "Open",
            closesTime: "3PM",
            dineIn: false,
            takeout: false,
            delivery: false,
            startingAt: nil,
            imageName: "park_cleanup" // You'll need to add this image asset
        )
    ]


    var body: some View {
        ZStack {
            // MARK: - Live Map
            Map(position: $cameraPosition) {
                UserAnnotation()

                ForEach(volunteerSites) { site in // Changed 'clinics' to 'volunteerSites'
                    Annotation(site.name, coordinate: site.coordinate) {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                if highlightedSiteId == site.id {
                                    highlightedSiteId = nil // Deselect if already highlighted
                                } else {
                                    highlightedSiteId = site.id // Highlight this site
                                }
                            }
                        }) {
                            VStack {
                                Image(systemName: "heart.fill") // Changed icon from "cross.case.fill" to "heart.fill" for volunteering
                                    .foregroundColor(highlightedSiteId == site.id ? .red : .orange) // Change color when highlighted
                                    .font(highlightedSiteId == site.id ? .title : .title2) // Make bigger when highlighted
                                    .scaleEffect(highlightedSiteId == site.id ? 1.3 : 1.0) // Scale effect for highlight
                                    .padding(6)
                                    .background(Circle().fill(Color.white).shadow(radius: 2))
                                Text(site.name) // Changed 'clinic.name' to 'site.name'
                                    .font(.caption2)
                                    .fixedSize()
                                    .padding(3)
                                    .background(Color.white.opacity(0.8))
                                    .cornerRadius(4)
                            }
                        }
                    }
                }
            }
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
            .ignoresSafeArea()
            .onReceive(loc.$lastCoordinate) { coord in
                guard let c = coord else { return }
                withAnimation {
                    cameraPosition = .region(MKCoordinateRegion(
                        center: c,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    ))
                }
            }
            .task {
                if loc.lastCoordinate == nil {
                    cameraPosition = .region(MKCoordinateRegion(
                        center: fallback,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    ))
                }
            }

            // MARK: - Search Bar and Back Button
            VStack {
                HStack {
                    Button(action: {
                        print("Back button tapped on map screen")
                        // In a real app, you would dismiss this view
                    }) {
                        Image(systemName: "arrow.backward")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding(10)
                            .background(Color.white.opacity(0.9))
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                    .padding(.leading, 15)

                    TextField("Search Volunteer Opportunities", text: $searchText) // Updated placeholder text
                        .padding(.vertical, 12)
                        .padding(.horizontal, 20)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(25)
                        .shadow(radius: 5)
                        .padding(.horizontal, 10)
                }
                .padding(.top, 50)
                Spacer()
            }

            // MARK: - Draggable Bottom Sheet
            VStack {
                Spacer()

                VStack(spacing: 0) {
                    // Drag Indicator (Down Arrow)
                    Image(systemName: "chevron.down")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.001))
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let newHeight = currentSheetHeight - value.translation.height
                                    let clampedHeight = max(minSheetHeight, min(maxSheetHeight, newHeight))
                                    self.sheetDragOffset = clampedHeight - currentSheetHeight
                                }
                                .onEnded { value in
                                    let predictedEndHeight = currentSheetHeight - value.predictedEndTranslation.height

                                    if predictedEndHeight > maxSheetHeight * 0.7 {
                                        currentSheetHeight = maxSheetHeight
                                    } else if predictedEndHeight < minSheetHeight + 50 {
                                        currentSheetHeight = minSheetHeight
                                    } else {
                                        currentSheetHeight = max(minSheetHeight, min(maxSheetHeight, predictedEndHeight))
                                    }
                                    self.sheetDragOffset = 0
                                }
                        )

                    // "Volunteering Nearby" Title
                    Text("Volunteering Nearby")
                        .font(.custom("Inter-SemiBold", size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.94, green: 0.45, blue: 0.24))
                        .padding(.bottom, 10)

                    // List of Locations
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(volunteeringLocations) { location in
                                LocationRow(location: location)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    }
                }
                .frame(height: currentSheetHeight + sheetDragOffset)
                .background(Color(red: 0.96, green: 0.95, blue: 0.88))
                .cornerRadius(25)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: -5)
            }

            // MARK: - Bottom Navigation Bar (Added)
            VStack {
                Spacer() // Pushes the navigation bar to the bottom

                VStack {
                    Divider() // A subtle line above the tab bar
                        .background(Color(red: 0.25, green: 0.35, blue: 0.20).opacity(0.3))
                        .padding(.horizontal, -20)

                    HStack {
                        Spacer()
                        // Location Icon
                        Button(action: {
                            selectedTab = "Location"
                            print("Location tab tapped")
                        }) {
                            VStack {
                                Image(systemName: "location.fill")
                                    .font(.title2)
                                Text("Location")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Location" ? Color(red: 0.94, green: 0.45, blue: 0.24) : Color(red: 0.25, green: 0.35, blue: 0.20))
                        Spacer()

                        // Badge Icon
                        Button(action: {
                            selectedTab = "Badge"
                            print("Badge tab tapped")
                        }) {
                            VStack {
                                Image(systemName: "rosette")
                                    .font(.title2)
                                Text("Badge")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Badge" ? Color(red: 0.94, green: 0.45, blue: 0.24) : Color(red: 0.25, green: 0.35, blue: 0.20))
                        Spacer()

                        // Home Icon
                        Button(action: {
                            navigationPath.path = NavigationPath() // Clear path
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
                        .foregroundColor(selectedTab == "Home" ? Color(red: 0.94, green: 0.45, blue: 0.24) : Color(red: 0.25, green: 0.35, blue: 0.20))
                        Spacer()

                        // Action Icon (Fist) - Changed to "hand.raised.fill" from "fist.raised.fill" for more volunteering feel
                        Button(action: {
                            selectedTab = "Action"
                            navigationPath.path = NavigationPath() // Clear path
                            navigationPath.path.append("ActionView")
                            print("Action tab tapped")
                        }) {
                            VStack {
                                Image(systemName: "hand.raised.fill")
                                    .font(.title2)
                                Text("Action")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(selectedTab == "Action" ? Color(red: 0.94, green: 0.45, blue: 0.24) : Color(red: 0.25, green: 0.35, blue: 0.20))
                        Spacer()

                        // Profile Icon
                        Button(action: {
                            selectedTab = "Profile"
                            navigationPath.path = NavigationPath() // Clear path
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
                        .foregroundColor(selectedTab == "Profile" ? Color(red: 0.94, green: 0.45, blue: 0.24) : Color(red: 0.25, green: 0.35, blue: 0.20))
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .background(Color(red: 0.96, green: 0.95, blue: 0.88))
                    .cornerRadius(20)
                    .shadow(radius: 5)
                }
                .padding(.bottom, 0)
            }
        }
    }
}

// MARK: - VolunteerSite (Data Model - Replace Clinic)
// This struct would ideally be in its own file: VolunteerSite.swift
struct VolunteerSite: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

// MARK: - LocationItem (Data Model) - Kept as is, but interpreted for volunteering
struct LocationItem: Identifiable {
    let id = UUID()
    let name: String
    let rating: Double
    let reviewCount: Int
    let priceRange: String // Could indicate "cost to participate" or just general "type"
    let cuisine: String // Re-interpreted as "category" or "focus area" for volunteering
    let address: String
    let openStatus: String
    let closesTime: String
    let dineIn: Bool // Re-interpreted as "on-site activity"
    let takeout: Bool // Re-interpreted as "remote/take-home tasks"
    let delivery: Bool // Re-interpreted as "delivery/outreach roles"
    let startingAt: Double? // Might indicate a suggested donation, or minimum hour commitment if applicable
    let imageName: String
}

// MARK: - LocationRow (View for each list item) - Adjusted for volunteering context
struct LocationRow: View {
    let location: LocationItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(location.name)
                        .font(.headline)
                        .foregroundColor(Color(red: 0.25, green: 0.35, blue: 0.20))

                    HStack(spacing: 2) {
                        ForEach(0..<5) { index in
                            Image(systemName: index < Int(location.rating) ? "star.fill" : "star")
                                .font(.caption)
                                .foregroundColor(.yellow)
                        }
                        Text("(\(location.reviewCount.formatted()))")
                            .font(.caption)
                            .foregroundColor(.gray)
                        // Price range can be interpreted differently for volunteering
                        Text("• \(location.priceRange)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    // Cuisine re-interpreted as 'Category' or 'Focus'
                    Text("\(location.cuisine) • \(location.address)")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    HStack {
                        Text(location.openStatus)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                        Text("• Closes \(location.closesTime)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    HStack {
                        if location.dineIn { // Re-purposed to "On-site"
                            StatusTag(text: "On-site", icon: "person.3.fill") // New icon
                        }
                        if location.takeout { // Re-purposed to "Remote Tasks"
                            StatusTag(text: "Remote Tasks", icon: "laptopcomputer") // New icon
                        }
                        if location.delivery { // Re-purposed to "Outreach"
                            StatusTag(text: "Outreach", icon: "hand.raised.fill") // New icon, similar to Action tab
                        }
                    }
                    .font(.caption)
                    .foregroundColor(.gray)

                    if let startingAt = location.startingAt {
                        // This text might need rephrasing if 'startingAt' refers to money
                        Text("Opportunity available from $\(startingAt, specifier: "%.1f")") // Rephrased for volunteering context
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 0.94, green: 0.45, blue: 0.24))
                    }
                }

                Spacer()

                VStack(spacing: 8) {
                    Image(location.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .cornerRadius(10)
                        .clipped()

                    HStack(spacing: 5) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 0.25, green: 0.35, blue: 0.20))
                                .frame(width: 30, height: 30)
                            Text("H") // Consider changing this to something more generic or contextual
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        Button(action: {
                            print("Details button tapped for \(location.name)")
                        }) {
                            Text("Details") // Changed from "Site" to "Details"
                                .font(.subheadline)
                                .foregroundColor(Color(red: 0.25, green: 0.35, blue: 0.20))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.white)
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color(red: 0.25, green: 0.35, blue: 0.20), lineWidth: 1)
                                )
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Helper View for Status Tags (Dine-in, Takeout, Delivery) - Adjusted
struct StatusTag: View {
    let text: String
    let icon: String // Using SF Symbols now

    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: icon) // Using systemName for SF Symbols
                .foregroundColor(.blue) // Changed color to blue, symbolizing activity/community
            Text(text)
        }
    }
}

// MARK: - Preview Provider

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LocationView()
                .environmentObject(NavigationPathManager())
        }
    }
}
