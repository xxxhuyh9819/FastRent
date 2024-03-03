//
//  ListView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct ExploreView: View {
    
    @State var showMap: Bool = false
    @EnvironmentObject var rootViewModel: MainViewModel
    
    var body: some View {
        NavigationStack {
            if rootViewModel.showSearchView {
                SearchView(showSearchView: $rootViewModel.showSearchView)
            } else {
                ScrollView {
                    SearchBar(location: $rootViewModel.location)
                        .onTapGesture {
                            withAnimation(.spring) {
                                rootViewModel.showSearchView.toggle()
                            }
                        }
                    
                    LazyVStack {
                        ForEach(rootViewModel.convertedHouses) { house in
                            NavigationLink {
                                DetailView(house: house)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                ListItemView(house: house)
                                    .tint(Color("font-color"))
                            }
                            .overlay {
                                FavoriteButton(house: house, imageName: rootViewModel.contains(house) ? "heart.fill" : "heart", size: 24)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity, maxHeight: .infinity/*@END_MENU_TOKEN@*/,  alignment: .topTrailing)
                                    .padding([.top, .trailing], 32)
                                    .onTapGesture {
                                        rootViewModel.toggleFavorite(convertedHouse: house)
                                    }
                            }
                            
                            Divider()
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
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .background(.gray)
                        .clipShape(Capsule())
                        .padding()
                    }
                    
                }
                .fullScreenCover(isPresented: $showMap) {
                    MapView(houses: rootViewModel.convertedHouses)
                }
            }
            
        }
    }
}

#Preview {
    ExploreView()
}
