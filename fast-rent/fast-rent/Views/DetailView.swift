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
    
    let apartment: Apartment
    
    init(apartment: Apartment) {
        self.apartment = apartment
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: apartment.latitude, longitude: apartment.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        self._cameraPosition = State(initialValue: .region(region))
    }

    var body: some View {
        ScrollView {
            // picture
            ImageCarousel(apartment: apartment)
                .frame(height: 320)
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
                Text(apartment.title)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text(apartment.address)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("\(apartment.numBedrooms) bedroom - \(apartment.numBathrooms) bathroom")
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
                    Text(apartment.landlordName)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                Image(.manAvatar)
                    .resizable()
                    .frame(width: 64, height: 64)
                    .scaledToFill()
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            }
            .padding(.leading)
            .padding(.trailing)
            
            Divider()
            
            // description
            VStack(alignment: .leading, spacing: 8) {
                Text("Description")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text(apartment.description)
                    
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding()
            
            Divider()
            
            // amenities
            VStack(alignment: .leading, spacing: 8) {
                Text("Amenities")
                    .font(.headline)
                    .fontWeight(.bold)
                
                ForEach(apartment.amenities, id: \.self) { amenity in
                    HStack {
                        Image(systemName: amenity.imageName)
                            .frame(width: 10)
                            .padding(.trailing, 5)
                        Text(amenity.title)
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal, 6)
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
                    Marker(apartment.apartmentName, coordinate: CLLocationCoordinate2D(latitude: 41.7936, longitude: -87.5859))
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
                        Text("$\(apartment.price) / month")
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
    DetailView(apartment: dummyApartment)
}
