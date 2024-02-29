//
//  ListView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct ExploreView: View {
    
    @State var showMap: Bool = false
    @StateObject var viewModel = ExploreViewModel()
    @State var selectedHouse: House?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(viewModel.houses, id: \.id) {house in
                    NavigationLink {
                        DetailView(house: house)
                            .navigationBarBackButtonHidden()
                    } label: {
                        ListItemView(house: house)
                            .tint(Color("font-color"))
                    }
                    .overlay {
                        FavoriteButton(house: house)
                            .padding([.top, .trailing])
                            .onTapGesture {
                                selectedHouse = house
                                if let city = selectedHouse?.name {
                                    print(city)
                                }
                            }
                    }
                }
            }
            .overlay(alignment: .bottom) {
                Button {
                    showMap.toggle()
                } label: {
                    HStack {
                        Text("Map")
                            .fontWeight(.semibold)
                        Image(systemName: "map.fill")
                    }
                    .frame(width: 84, height: 30)
                    .foregroundStyle(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .background(.gray)
                    .clipShape(Capsule())
                    .padding()
                }
                
            }
            .sheet(isPresented: $showMap) {
                MapView(houses: viewModel.houses)
            }
        }
    }
}

#Preview {
    ExploreView()
}
