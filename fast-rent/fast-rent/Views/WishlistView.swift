//
//  WishlistsView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct WishlistView: View {
    
    @StateObject var viewModel = WishlistViewModel()
    
    var favHouses: [ConvertedHouse] {
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
                LazyVGrid(columns: columns, spacing: 2) {
                    ForEach(favHouses, id: \.self) { house in
                        HStack {
                            WishlistItemView(convertedHouse: house)
                                .frame(width: 160, height: 200)
                        }
                        .overlay {
                            FavoriteButton(house: house, imageName: fast_rentApp.db.contains(house, viewModel.savedItems) ? "heart.fill" : "heart")
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                .onTapGesture {
                                    print("tapped")
                                    fast_rentApp.db.toggleFav(convertedHouse: house, savedHouses: &viewModel.savedItems)
                                }
                        }
                        
                        
                    }
                }
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

//#Preview {
//    WishlistView(wishlist: dummyApartments)
//}
