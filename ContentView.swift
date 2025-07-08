import SwiftUI
import MapKit // Import MapKit for the map view
import CoreLocation // For CLLocationCoordinate2D and CLLocationManager (though LocationManager handles it)

// MARK: - Data Models

// MARK: - Main View
struct ContentView: View { // This is now your main map view
    // 1️⃣ Live-location publisher
    @StateObject private var loc = LocationManager()
    
    // 2️⃣ Prototype clinics (hard-coded)
    private let clinics: [Clinic] = [
        .init(name: "City Health Clinic",
              coordinate: .init(latitude: 41.880, longitude: -87.629)),
        .init(name: "CareWell Medical",
              coordinate: .init(latitude: 41.877, longitude: -87.626)),
        .init(name: "Downtown Wellness",
              coordinate: .init(latitude: 41.879, longitude: -87.630))
    ]
    
    // 3️⃣ Fallback "fake" location = downtown Chicago
    private let fallback = CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298)
    
    // 4️⃣ Map camera position (centers on live if available, else fallback)
    // Using MapCameraPosition for iOS 17+
    @State private var cameraPosition: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    ))
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // ---------------- Map ----------------
            // Updated Map initializer for iOS 17+
            Map(position: $cameraPosition) {
                // Show user's current location (blue dot)
                UserAnnotation()

                // Add clinic annotations
                ForEach(clinics) { clinic in
                    // FIX: Added 'id: clinic.id' to the Annotation initializer
                    Annotation(clinic.name, coordinate: clinic.coordinate) { // <-- Corrected
                        VStack {
                            Image(systemName: "cross.case.fill") // Icon for clinics
                                .foregroundColor(.red)
                                .padding(6)
                                .background(Circle().fill(Color.white).shadow(radius: 2))
                            Text(clinic.name)
                                .font(.caption2)
                                .fixedSize() // Prevent text from wrapping
                                .padding(3)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(4)
                        }
                    }
                }
            }
            .mapControls { // New modifier for map controls like the user location button
                MapUserLocationButton() // Re-center button
                MapCompass() // Optional: Adds a compass
                MapScaleView() // Optional: Adds a scale bar
            }
            .ignoresSafeArea() // Extends map to edges of the screen
            
            // -------- Re-center FAB (Floating Action Button) ----------
            // This button is now redundant if MapUserLocationButton() is used,
            // but kept for demonstration if you want a custom one.
            // If you use MapUserLocationButton(), you can remove this custom button.
            Button {
                if let c = loc.lastCoordinate {
                    withAnimation {
                        cameraPosition = .region(MKCoordinateRegion(
                            center: c,
                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        ))
                    }
                }
            } label: {
                Image(systemName: "location.fill")
                    .padding(12)
                    .background(.thinMaterial, in: Circle()) // Frosted glass effect
            }
            .padding()
        }
        // Keep camera position in sync with live GPS
        .onReceive(loc.$lastCoordinate) { coord in
            guard let c = coord else { return }
            // Update camera position when new location is received
            cameraPosition = .region(MKCoordinateRegion(
                center: c,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            ))
        }
        // On first launch, fall back to Chicago until GPS arrives
        .task {
            if loc.lastCoordinate == nil {
                cameraPosition = .region(MKCoordinateRegion(
                    center: fallback,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                ))
            }
        }
    }
}

// MARK: - Preview Provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

