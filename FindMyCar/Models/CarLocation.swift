import Foundation
import CoreLocation

// Helper struct to make car locations identifiable for Map annotations
struct CarLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
    let subtitle: String
}
//  CarLocation.swift
//  FindMyCar
//
//  Created by Apple on 31/10/2026.
//

