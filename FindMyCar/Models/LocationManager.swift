import Foundation
import CoreLocation
import Observation

@Observable
class LocationManager: NSObject {

    // MARK: - Observable Properties

    var coordinate = CarCoordinate()
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    var locationError: String?

    // MARK: - Private Properties

    @ObservationIgnored private let locationManager = CLLocationManager()
    @ObservationIgnored private let plistFileName = "Coordinates.plist"
    @ObservationIgnored private var locationSaveCompletion: (() -> Void)?

    // MARK: - Initialization

    // Initializes the location manager and loads previously saved coordinates
    override init() {
        super.init()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone

        authorizationStatus = locationManager.authorizationStatus

        loadLocation()
    }

    // MARK: - Public Methods

    // Requests permission and retrieves the current device location
    func saveCurrentLocation(completion: @escaping () -> Void = {}) {

        locationError = nil
        locationSaveCompletion = completion

        switch authorizationStatus {

        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()

        case .restricted, .denied:
            locationError = "Location access denied. Please enable in Settings."
            locationSaveCompletion?()
            locationSaveCompletion = nil
            return

        case .authorizedWhenInUse, .authorizedAlways:
            startLocationUpdates()

        @unknown default:
            locationError = "Unknown authorization status"
            locationSaveCompletion?()
            locationSaveCompletion = nil
        }
    }

    // Resets the saved coordinates and updates the plist file
    func clearLocation() {
        coordinate = CarCoordinate()
        saveLocationToPlist()
    }

    // MARK: - Persistence Methods

    // Encodes and saves the current coordinates to a plist file
    private func saveLocationToPlist() {
        do {
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml

            let data = try encoder.encode(coordinate)

            try data.write(to: plistURL(), options: .atomic)

        } catch {
            print("Error saving location: \(error.localizedDescription)")
            locationError = "Failed to save location"
        }
    }

    // Loads previously saved coordinates from the plist file
    private func loadLocation() {

        let url = plistURL()

        guard FileManager.default.fileExists(atPath: url.path) else {
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()

            coordinate = try decoder.decode(
                CarCoordinate.self,
                from: data
            )

        } catch {
            print("Error loading location: \(error.localizedDescription)")
        }
    }

    // MARK: - Private Helper Methods

    // Starts GPS updates if location services are enabled
    private func startLocationUpdates() {

        guard CLLocationManager.locationServicesEnabled() else {
            locationError = "Location services are disabled"
            return
        }

        locationManager.startUpdatingLocation()
    }

    // Returns the URL of the plist file in the documents directory
    private func plistURL() -> URL {
        URL.documentsDirectory.appendingPathComponent(plistFileName)
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {

    // Responds to changes in location authorization
    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {

        authorizationStatus = manager.authorizationStatus

        if authorizationStatus == .authorizedWhenInUse ||
            authorizationStatus == .authorizedAlways {

            startLocationUpdates()
        }
    }

    // Receives GPS updates, saves the coordinates, and stops location updates
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {

        guard let location = locations.last else {
            return
        }

        coordinate = CarCoordinate(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )

        saveLocationToPlist()

        locationManager.stopUpdatingLocation()

        locationSaveCompletion?()
        locationSaveCompletion = nil
    }

    // Handles errors received from CoreLocation
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {

        locationError = "Failed to get location: \(error.localizedDescription)"

        locationManager.stopUpdatingLocation()

        locationSaveCompletion?()
        locationSaveCompletion = nil
    }
}
//  LocationManager.swift
//  FindMyCar
//
//  Created by Apple on 31/10/2026.
//

