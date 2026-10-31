import Foundation

// Codable struct for saving coordinates to a property list
struct CarCoordinate: Codable, Equatable {
    var latitude: Double
    var longitude: Double

    // Initializes coordinates with default values of zero
    init(latitude: Double = 0.0, longitude: Double = 0.0) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
//  CarCoordinate.swift
//  FindMyCar
//
//  Created by Apple on 31/10/2026.
//

