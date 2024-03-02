//
//  WishlistsView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct WishlistView: View {
    
    @EnvironmentObject var viewModel: MainViewModel
    @State var isDeleting = false
    
    var favoriteHouses: [ConvertedHouse] {
        return Array(viewModel.savedItems)
    }

    
    var body: some View {
        
        // 2 items per row
        let columns: [GridItem] = [
                GridItem(),
                GridItem()
            ]
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(favoriteHouses, id: \.self) { house in
                        HStack {
                            WishlistItemView(convertedHouse: house)
                                .frame(width: 160, height: 200)
                        }
                        .overlay {
                            FavoriteButton(house: house, imageName: fast_rentApp.db.contains(house, viewModel.savedItems) ? "heart.fill" : "heart", size: 24)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                .padding([.top, .trailing], 16)
                                .onTapGesture {
                                    isDeleting = true
                                }
                            // show an alert after clicking the wishlist icon
                                .alert("Remove from wishlist?", isPresented: $isDeleting) {
                                    Button("Remove", role: .destructive) {
                                        fast_rentApp.db.toggleFavorite(convertedHouse: house, savedHouses: &viewModel.savedItems)
                                        isDeleting = false
                                    }
                                    Button("Cancel", role: .cancel) {
                                        isDeleting = false
                                    }
                                } message: {
                                    Text("\"\(house.title)\" will be permanently deleted.")
                                }
                        }
                        
                        
                    }
                }
                .padding(.top)
                
            }
            .navigationTitle("Wishlist")
            .navigationBarTitleDisplayMode(.inline)
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
    WishlistView()
}
