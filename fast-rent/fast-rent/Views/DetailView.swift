//
//  DetailView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI
import MapKit

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var cameraPosition: MapCameraPosition
    
    init() {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.7936, longitude: -87.5859), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        self._cameraPosition = State(initialValue: .region(region))
    }

    var body: some View {
        ScrollView {
            // picture
            CarouselView()
                .frame(height: 350)
            // custom back button
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
                            .padding(.vertical, 56)
                    }
                }
            
            // Apartment info
            VStack(alignment: .leading, spacing: 8) {
                Text("Luxury 1B1B Apartment")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text("1616 E 56th St, Chicago, IL")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("1 bedroom - 1 bathroom")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding(.leading)
            
            Divider()
            
            // Landlord info
            HStack {
                VStack(alignment: .leading) {
                    Text("Landlord")
                        .font(.headline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("Alan Walker")
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 64, height: 64)
                    .scaledToFill()
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            }
            .padding()
            
            Divider()
            
            // description
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut condimentum tellus at sagittis ullamcorper. Praesent ipsum dui, fringilla nec nulla nec, commodo dictum tortor. Suspendisse tempus maximus metus, ac facilisis dolor facilisis in. Integer a sagittis sem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sit amet mollis ")
                .padding()
            
            Divider()
            
            // amenities
            VStack(alignment: .leading, spacing: 8) {
                Text("Amenities")
                    .font(.headline)
                    .fontWeight(.bold)
                
                ForEach(0..<3) {_ in
                    HStack {
                        Image(systemName: "washer")
                        Text("Laundry")
                    }
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding(.leading)
            
            Divider()
            
            // map location
            VStack(alignment: .leading) {
                Text("Location")
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Map(position: $cameraPosition) {
                    Marker("Solstice", coordinate: CLLocationCoordinate2D(latitude: 41.7936, longitude: -87.5859))
                }
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding()
            .padding(.bottom, 64)
            
        }
        .ignoresSafeArea()
        .overlay(alignment: .bottom) {
            VStack {
                Divider()
                    .padding(.bottom)
                
                // price
                HStack {
                    VStack(alignment: .leading) {
                        Text("$1900 / month")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text("For 12 months")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                    
                    Button {
                        // action
                    } label: {
                        Text("Contact")
                            .foregroundStyle(.white)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width: 140, height: 40)
                            .background(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .padding(.horizontal)
            .background(.white)
        }
        .padding(.bottom)
    }
}

#Preview {
    DetailView()
}
