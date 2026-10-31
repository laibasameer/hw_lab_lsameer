import Testing
import CoreLocation
@testable import FindMyCar

@MainActor
struct LocationManagerTests {

    // Tests whether LocationManager starts with zero coordinates
    @Test func startsWithZeroCoordinate() {

        let manager = LocationManager()

        #expect(manager.coordinate == CarCoordinate())
    }

    // Tests whether clearLocation resets the saved coordinates
    @Test func clearLocationResetsCoordinate() {

        let manager = LocationManager()

        manager.coordinate = CarCoordinate(
            latitude: 40.4446,
            longitude: -79.9454
        )

        manager.clearLocation()

        #expect(manager.coordinate == CarCoordinate())
    }

    // Tests whether denied location permission produces an error
    @Test func deniedAuthorizationProducesError() {

        let manager = LocationManager()

        manager.authorizationStatus = .denied

        manager.saveCurrentLocation()

        #expect(manager.locationError != nil)
    }
}
//  LocationManagerTests.swift
//  FindMyCar
//
//  Created by Apple on 31/10/2026.
//

