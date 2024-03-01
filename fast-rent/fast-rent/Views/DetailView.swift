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
    @State var showMap: Bool = false
    @StateObject var viewModel: DetailViewModel
    @EnvironmentObject var rootViewModel: MainViewModel
    
    let house: ConvertedHouse
    
    init(house: ConvertedHouse) {
        self.house = house
        self._viewModel = StateObject(wrappedValue: DetailViewModel(house: house))
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: house.latitude, longitude: house.longitude), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        self._cameraPosition = State(initialValue: .region(region))
    }
    
    var body: some View {
        ScrollView {
            // picture
            ImageCarousel(house: house)
                .frame(height: 320)
            
            // custom back button
                .overlay(alignment: .topLeading) {
                    HStack {
                        RoundButton(imageName: "chevron.left")
                            .onTapGesture {
                                dismiss()
                            }
                        
                        Spacer()
                        
                        FavoriteButton(house: house, imageName: fast_rentApp.db.contains(house, rootViewModel.savedItems) ? "heart.fill" : "heart", size: 24)
                            .onTapGesture {
                                fast_rentApp.db.toggleFav(convertedHouse: house, savedHouses: &rootViewModel.savedItems)
                            }
                    }
                    .padding(.top, 48)
                    .padding(.horizontal, 20)
                }
            
            // Apartment info
            VStack(alignment: .leading, spacing: 8) {
                Text(house.title)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text(house.address)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("\(house.numBedrooms) bedroom - \(house.numBathrooms) bathroom")
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
                    Text(viewModel.landlord?.name ?? "")
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                if let url = viewModel.landlord?.avatarUrl {
                    Image(url)
                        .resizable()
                        .frame(width: 64, height: 64)
                        .scaledToFill()
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                } else {
                    Image(systemName: "person.slash.fill")
                        .resizable()
                        .frame(width: 64, height: 64)
                        .scaledToFill()
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                }
            }
            .padding(.leading)
            .padding(.trailing)
            
            Divider()
            
            // description
            VStack(alignment: .leading, spacing: 8) {
                Text("Description")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text(house.description)
                
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding()
            
            Divider()
            
            // amenities
            VStack(alignment: .leading, spacing: 8) {
                Text("Amenities")
                    .font(.headline)
                    .fontWeight(.bold)
                
                ForEach(viewModel.amenities, id: \.id) { amenity in
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
                    Annotation("$\(house.price)", coordinate: CLLocationCoordinate2D(latitude: house.latitude, longitude: house.longitude)) {
                        ApartmentButton(house: house)
                            .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    }
                }
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onTapGesture {
                    showMap.toggle()
                }
                .sheet(isPresented: $showMap, content: {
                    MapView(houses: [house])
                })
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
                        Text("$\(house.price) / month")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text("For 12 months")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                    
                    HStack {
                        // src: https://stackoverflow.com/questions/57582653/how-to-create-tappable-url-phone-number-in-swiftui
                        // will produce warnings in simulators, works well in real devices
                        if let tel = viewModel.landlord?.tel {
                            Link(destination: URL(string: "tel:\(tel)")!) {
                                Image(systemName: "phone.fill")
                                    .foregroundStyle(.white)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .frame(width: 40, height: 40)
                                    .background(.red)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .padding(.horizontal, 10)
                        }
                        
                        
                        if let email = viewModel.landlord?.email {
                            Link(destination: URL(string: "mailto:\(email)")!) {
                                Image(systemName: "envelope.fill")
                                    .foregroundStyle(.white)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .frame(width: 40, height: 40)
                                    .background(.red)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .padding(.horizontal, 10)
                        }
                        
                    }
                }
            }
            .padding(.horizontal)
            .background(Color("background-color"))
        }
        .padding(.bottom)
    }
}

#Preview {
    DetailView(house: ConvertedHouse(house: Preview.dummyApartment))
}
