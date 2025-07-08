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

    let minSheetHeight: CGFloat = UIScreen.main.bounds.height * 0.3
    let maxSheetHeight: CGFloat = UIScreen.main.bounds.height * 0.85

    // Live-location publisher
    @StateObject private var loc = LocationManager()
    
    // Prototype clinics (hard-coded)
    // Clinic is now accessed from Clinic.swift
    private let clinics: [Clinic] = [
        .init(name: "City Health Clinic",
              coordinate: .init(latitude: 41.880, longitude: -87.629)),
        .init(name: "CareWell Medical",
              coordinate: .init(latitude: 41.877, longitude: -87.626)),
        .init(name: "Downtown Wellness",
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

    // Mock data for volunteering locations
    let volunteeringLocations: [LocationItem] = [
        LocationItem(
            name: "Bonefish Grill",
            rating: 4.6,
            reviewCount: 1581,
            priceRange: "$$",
            cuisine: "Seafood restaurant",
            address: "1604 Randall Road",
            openStatus: "Open",
            closesTime: "11PM",
            dineIn: true,
            takeout: true,
            delivery: true,
            startingAt: 18.9,
            imageName: "bonefish_grill"
        ),
        LocationItem(
            name: "Cooper's Hawk Winery & Restaurant- Algonquin, IL",
            rating: 4.7,
            reviewCount: 872,
            priceRange: "$30 - $50",
            cuisine: "American",
            address: "1741 S Randall Road",
            openStatus: "Open",
            closesTime: "10PM",
            dineIn: true,
            takeout: false,
            delivery: false,
            startingAt: nil,
            imageName: "coopers_hawk"
        ),
        LocationItem(
            name: "The Giving Kitchen",
            rating: 4.9,
            reviewCount: 250,
            priceRange: "$",
            cuisine: "Non-profit",
            address: "123 Volunteer Way",
            openStatus: "Open",
            closesTime: "5PM",
            dineIn: false,
            takeout: false,
            delivery: false,
            startingAt: nil,
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
        )
    ]

    var body: some View {
        ZStack {
            // MARK: - Live Map
            Map(position: $cameraPosition) {
                UserAnnotation()

                ForEach(clinics) { clinic in
                    Annotation(clinic.name, coordinate: clinic.coordinate) {
                        VStack {
                            Image(systemName: "cross.case.fill")
                                .foregroundColor(.red)
                                .padding(6)
                                .background(Circle().fill(Color.white).shadow(radius: 2))
                            Text(clinic.name)
                                .font(.caption2)
                                .fixedSize()
                                .padding(3)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(4)
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

                    TextField("Search Maps", text: $searchText)
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
                            selectedTab = "Home"
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

                        // Action Icon (Fist)
                        Button(action: {
                            selectedTab = "Action"
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

// MARK: - LocationItem (Data Model)
struct LocationItem: Identifiable {
    let id = UUID()
    let name: String
    let rating: Double
    let reviewCount: Int
    let priceRange: String
    let cuisine: String
    let address: String
    let openStatus: String
    let closesTime: String
    let dineIn: Bool
    let takeout: Bool
    let delivery: Bool
    let startingAt: Double?
    let imageName: String
}

// MARK: - LocationRow (View for each list item)
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
                        Text("• \(location.priceRange)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

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
                        if location.dineIn {
                            StatusTag(text: "Dine-in", icon: "fork.knife")
                        }
                        if location.takeout {
                            StatusTag(text: "Takeout", icon: "bag.fill")
                        }
                        if location.delivery {
                            StatusTag(text: "Delivery", icon: "car.fill")
                        }
                    }
                    .font(.caption)
                    .foregroundColor(.gray)

                    if let startingAt = location.startingAt {
                        Text("Starting At Just $\(startingAt, specifier: "%.1f")")
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
                            Text("H")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        Button(action: {
                            print("Site button tapped for \(location.name)")
                        }) {
                            Text("Site")
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

// MARK: - Helper View for Status Tags (Dine-in, Takeout, Delivery)
struct StatusTag: View {
    let text: String
    let icon: String

    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: icon)
                .foregroundColor(.green)
            Text(text)
        }
    }
}

// MARK: - Preview Provider
struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
