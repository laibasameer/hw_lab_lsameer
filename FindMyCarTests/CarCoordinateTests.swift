import Testing
import Foundation
@testable import FindMyCar

struct CarCoordinateTests {

    // Tests whether the default initializer sets coordinates to zero
    @Test func defaultInitializerIsZero() {

        let coord = CarCoordinate()

        #expect(coord.latitude == 0.0)
        #expect(coord.longitude == 0.0)
    }

    // Tests whether the custom initializer stores the correct coordinates
    @Test func customInitializerStoresValues() {

        let coord = CarCoordinate(
            latitude: 40.7128,
            longitude: -74.0060
        )

        #expect(coord.latitude == 40.7128)
        #expect(coord.longitude == -74.0060)
    }

    // Tests whether two CarCoordinate objects can be compared
    @Test func equalityWorks() {

        let a = CarCoordinate(
            latitude: 40.4446,
            longitude: -79.9454
        )

        let b = CarCoordinate(
            latitude: 40.4446,
            longitude: -79.9454
        )

        let c = CarCoordinate(
            latitude: 0,
            longitude: 0
        )

        #expect(a == b)
        #expect(a != c)
    }

    // Tests whether coordinates can be encoded and decoded using plist
    @Test func encodesAndDecodesRoundTrip() throws {

        let original = CarCoordinate(
            latitude: 40.4446,
            longitude: -79.9454
        )

        let data = try PropertyListEncoder().encode(original)

        let decoded = try PropertyListDecoder().decode(
            CarCoordinate.self,
            from: data
        )

        #expect(decoded == original)
    }
}
//  CarCoordinateTests.swift
//  FindMyCar
//
//  Created by Apple on 31/10/2026.
//

