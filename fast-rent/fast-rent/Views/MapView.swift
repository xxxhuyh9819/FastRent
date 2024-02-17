//
//  MapView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )

        var body: some View {
            Map(coordinateRegion: $region, showsUserLocation: true)
                .onAppear {
                    // Request permission to use location services
                    let locationManager = CLLocationManager()
                    locationManager.requestWhenInUseAuthorization()

                    // Set the initial region to the user's current location
                    locationManager.startUpdatingLocation()
                    if let location = locationManager.location {
                        region.center = location.coordinate
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .overlay(alignment: .topLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.gray)
                            .background {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 28, height: 28)
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 32)
                    }
                }
        }
}

#Preview {
    MapView()
}
