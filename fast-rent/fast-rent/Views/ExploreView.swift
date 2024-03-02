//
//  ListView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct ExploreView: View {
    
    @State var showMap: Bool = false
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationStack {
            if viewModel.showSearchView {
                SearchView(showSearchView: $viewModel.showSearchView)
            } else {
                ScrollView {
                    SearchBar(location: $viewModel.location)
                        .onTapGesture {
                            withAnimation(.spring) {
                                viewModel.showSearchView.toggle()
                            }
                        }
                    
                    LazyVStack {
                        ForEach(viewModel.convertedHouses) { house in
                            NavigationLink {
                                DetailView(house: house)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                ListItemView(house: house)
                                    .tint(Color("font-color"))
                            }
                            .overlay {
                                FavoriteButton(house: house, imageName: fast_rentApp.db.contains(house, viewModel.savedItems) ? "heart.fill" : "heart", size: 24)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity, maxHeight: .infinity/*@END_MENU_TOKEN@*/,  alignment: .topTrailing)
                                    .padding([.top, .trailing], 32)
                                    .onTapGesture {
                                        print("Ex")
                                        fast_rentApp.db.toggleFav(convertedHouse: house, savedHouses: &viewModel.savedItems)
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
                    MapView(houses: viewModel.convertedHouses)
                }
            }
            
        }
        // refresh the saved items upon entering and leaving the page
        .onAppear() {
            viewModel.savedItems = fast_rentApp.db.load()
        }
        .onDisappear {
            viewModel.savedItems = fast_rentApp.db.load()
        }
    }
}

#Preview {
    ExploreView()
}
