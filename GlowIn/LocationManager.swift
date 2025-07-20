//
//  LocationManager.swift
//  GlowIn
//
//  Created by SandboxLab on 7/7/25.
//

import Foundation
import CoreLocation
import Combine

/// Publishes the user's most-recent coordinate.
final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var lastCoordinate: CLLocationCoordinate2D?
    
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.activityType   = .other
        manager.requestWhenInUseAuthorization()   // show permission alert
        manager.startUpdatingLocation()           // begin GPS updates
    }
    
    // CoreLocation callback
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        lastCoordinate = locations.last?.coordinate
    }
    
    // Optional: react if permission is denied & stop updates
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard manager.authorizationStatus == .authorizedWhenInUse ||
              manager.authorizationStatus == .authorizedAlways else {
            manager.stopUpdatingLocation()
            return
        }
    }
}
