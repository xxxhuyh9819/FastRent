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
    let houses: [ConvertedHouse]
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    init(houses: [ConvertedHouse]) {
        self.houses = houses
    }
    
    var body: some View {
        ZStack {
            Map(position: $cameraPosition) {
                ForEach(houses, id: \.id) { house in
                    Annotation("$\(house.price)", coordinate: CLLocationCoordinate2D(latitude: house.latitude, longitude: house.longitude)) {
                        ApartmentButton(house: house)
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .overlay(alignment: .topLeading) {
            RoundButton(imageName: "chevron.left")
                .onTapGesture {
                    dismiss()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 32)
        }
    }
}

#Preview {
    MapView(houses: [ConvertedHouse(house: Preview.dummyApartment)])
}
