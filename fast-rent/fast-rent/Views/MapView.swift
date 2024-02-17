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
    let apartments: [Apartment]
    @State private var cameraPosition: MapCameraPosition
    
    init(apartments: [Apartment], center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 41.7936, longitude: -87.5859)) {
        self.apartments = apartments
        
        let coordinateRegion = MKCoordinateRegion(
            center: center,
            latitudinalMeters: 10000,
            longitudinalMeters: 10000
        )
        self._cameraPosition = State(initialValue: .region(coordinateRegion))
    }
    
    
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )

        var body: some View {
            Map(position: $cameraPosition) {
                ForEach(apartments, id: \.id) { apartment in
                    Annotation("$\(apartment.price)", coordinate: CLLocationCoordinate2D(latitude: apartment.latitude, longitude: apartment.longitude)) {
                        PlaceButton()
                    }
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
    MapView(apartments: dummyApartments)
}
