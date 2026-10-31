import SwiftUI
import MapKit

struct MapView: View {

    // MARK: - Properties

    var locationManager: LocationManager

    @State private var position: MapCameraPosition = .automatic

    // MARK: - Computed Properties

    // Converts the saved car coordinates into a MapKit coordinate
    private var carCoordinate: CLLocationCoordinate2D {

        CLLocationCoordinate2D(
            latitude: locationManager.coordinate.latitude,
            longitude: locationManager.coordinate.longitude
        )
    }

    // Checks whether a valid car location has been saved
    private var hasLocation: Bool {

        locationManager.coordinate.latitude != 0 ||
        locationManager.coordinate.longitude != 0
    }

    // MARK: - Helper Methods

    // Updates the map camera to center on the saved car location
    private func updateMapPosition() {

        guard hasLocation else {
            return
        }

        let region = MKCoordinateRegion(
            center: carCoordinate,
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01
            )
        )

        position = .region(region)
    }

    // MARK: - Body

    var body: some View {

        ZStack {

            Map(position: $position) {

                // Displays the user's current location
                UserAnnotation()

                // Displays the car marker if a location exists
                if hasLocation {

                    Annotation(
                        "Your Car is Here",
                        coordinate: carCoordinate
                    ) {

                        VStack(spacing: 4) {

                            Image(systemName: "car.fill")
                                .font(.title)
                                .foregroundColor(.red)
                                .padding(8)
                                .background(
                                    Circle().fill(Color.white)
                                )
                                .shadow(radius: 3)

                            Text("Your Car")
                                .font(.caption)
                                .padding(4)
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(4)
                                .shadow(radius: 2)
                        }
                    }
                }
            }

            // Map Controls
            .mapControls {

                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }

            .ignoresSafeArea()

            // Center the map when the view appears
            .onAppear {
                updateMapPosition()
            }

            // Update map when the saved coordinates change
            .onChange(of: locationManager.coordinate) { _, _ in
                updateMapPosition()
            }

            // Information card at the top
            VStack {

                if hasLocation {

                    VStack(alignment: .leading, spacing: 4) {

                        Text("Your Car Location")
                            .font(.headline)

                        Text(
                            "Lat: \(String(format: "%.6f", carCoordinate.latitude))"
                        )
                        .font(.caption)

                        Text(
                            "Lon: \(String(format: "%.6f", carCoordinate.longitude))"
                        )
                        .font(.caption)
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
                }

                Spacer()
            }
        }
        .navigationTitle("Map View")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview

#Preview {

    let manager = LocationManager()

    // Uses CMU coordinates as a sample location for the preview
    manager.coordinate = CarCoordinate(
        latitude: 40.444644,
        longitude: -79.945424
    )

    return NavigationStack {
        MapView(locationManager: manager)
    }
}
//  MapView.swift
//  FindMyCar
//
//  Created by Apple on 31/10/2026.
//

