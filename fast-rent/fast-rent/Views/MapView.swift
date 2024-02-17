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
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    init(apartments: [Apartment]) {
        self.apartments = apartments
    }

    var body: some View {
        ZStack {
            Map(position: $cameraPosition) {
                ForEach(apartments, id: \.id) { apartment in
                    Annotation("$\(apartment.price)", coordinate: CLLocationCoordinate2D(latitude: apartment.latitude, longitude: apartment.longitude)) {
                        ApartmentButton(apartment: apartment)
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .overlay(alignment: .topLeading) {
//            Button {
//                dismiss()
//            } label: {
//                Image(systemName: "chevron.left")
//                    .foregroundStyle(.gray)
//                    .imageScale(.small)
//                    .background {
//                        Circle()
//                            .fill(.white)
//                            .frame(width: 28, height: 28)
//                    }
//                    .padding(.horizontal, 24)
//                    .padding(.vertical, 32)
//            }
            Circle()
                .fill(Color("round-button-color"))
                .frame(width: 28, height: 28)
                .overlay(
                    Image(systemName: "xmark")
                        .imageScale(.small)
                        .font(.callout.weight(.bold))
                        .foregroundStyle(.gray)
                )
                .onTapGesture {
                    dismiss()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 32)
        }
    }
}

#Preview {
    MapView(apartments: dummyApartments)
}
