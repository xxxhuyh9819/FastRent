//
//  WishlistsView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI
import OSLog

struct WishlistView: View {
    
    @EnvironmentObject var rootViewModel: MainViewModel
    @State var isDeleting = false
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                LazyVStack() {
                    ForEach(rootViewModel.savedItems.sorted {$0.price < $1.price} ) { house in
                        HStack {
                            WishlistItemView(house: house)
                        }
                        .overlay {
                            FavoriteButton(house: house, imageName: rootViewModel.contains(house) ? "heart.fill" : "heart", size: 24)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                .padding([.top, .trailing], 16)
                                .onTapGesture {
                                    Logger.localStorage.debug("In \(WishlistView.self): Starting to delete \(house.name) from userdefaults...")
                                    rootViewModel.toggleFavorite(convertedHouse: house)
                                    isDeleting = true
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
//        .onAppear() {
//            rootViewModel.savedItems = fast_rentApp.db.load()
//        }
//        .onDisappear {
//            rootViewModel.savedItems = fast_rentApp.db.load()
//        }
    }
}

#Preview {
    WishlistView()
}
