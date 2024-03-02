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
    @EnvironmentObject var viewModel: MainViewModel
    @State var showInfo = false
    @State private var showSearchView = false
    @State var selectedHouse: ConvertedHouse?
    
    init(houses: [ConvertedHouse]) {
        self.houses = houses
    }
    
    var body: some View {
        if (showSearchView) {
            SearchView(showSearchView: $showSearchView)
        } else {
            NavigationStack {
                ZStack {
                    Map(position: $cameraPosition, interactionModes: [.zoom, .pan]) {
                        ForEach(houses, id: \.id) { house in
                            Annotation("$\(house.price)", coordinate: CLLocationCoordinate2D(latitude: house.latitude, longitude: house.longitude)) {
                                ApartmentButton(house: house)
                                    .onTapGesture {
                                        selectedHouse = house
                                        showInfo = true
                                    }
                            }
                        }
                    }
                    .mapStyle(.standard(
                        elevation: .flat,
                        showsTraffic: false
                    ))
                    
                    if let house = selectedHouse {
                        if (showInfo) {
                            withAnimation(.spring) {
                                HouseInfoView(house: house, showInfo: $showInfo)
                                    .modifier(SwipeToDismissModifier(onDismiss: {showInfo.toggle()}))
                               
                            }
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .overlay(alignment: .topLeading) {
                    HStack {
                        RoundButton(imageName: "chevron.left")
                            .onTapGesture {
                                dismiss()
                            }
                        
                        Spacer()
                    }
                    .padding()
                }
            }
        }
        
    }
}

#Preview {
    MapView(houses: [Preview.dummyHouse])
}
