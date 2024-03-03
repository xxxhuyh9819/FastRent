//
//  WishlistItemView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI
import OSLog

/// An extracted view to contain a single House in the Wishlist View
struct WishlistItemView: View {
    
    let house: ConvertedHouse
    @EnvironmentObject var rootViewModel: MainViewModel
    @State var isDeleting = false
    
    var body: some View {
        
        ZStack {
            VStack {
                ImageCarousel(house: house)
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(house.name)")
                            .font(.subheadline)
                        Text("\(house.address), \(house.city)")
                            
                        Text("\(house.numBedrooms) bedroom - \(house.numBathrooms) bathroom")
                    }
                    .font(.footnote)
                    .fontWeight(.semibold)
                    
                    Spacer()
                    

                    Text("$\(house.price)")
                        .fontWeight(.bold)
                    
                }
            }
            .padding()
            
            FavoriteButton(house: house, imageName: rootViewModel.contains(house) ? "heart.fill" : "heart", size: 24)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding([.top, .trailing], 32)
                .onTapGesture {
                    if (rootViewModel.contains(house)) {
                        Logger.localStorage.info("In \(WishlistItemView.self): Planning to delete \(house.name) from wishlist...")
                        isDeleting = true
                    } else {
                        rootViewModel.toggleFavorite(house: house)
                    }
                }
            // show an alert after clicking the wishlist icon
                .alert("Remove from wishlist?", isPresented: $isDeleting) {
                    Button("Remove", role: .destructive) {
                        Logger.localStorage.info("In \(WishlistItemView.self): Starting to delete \(house.name) from wishlist...")
                        rootViewModel.toggleFavorite(house: house)
                        isDeleting = false
                    }
                    Button("Cancel", role: .cancel) {
                        isDeleting = false
                    }
                } message: {
                    Text("\"\(house.name)\" will be permanently deleted.")
                }
        }
        
        
    }
}

#Preview {
    WishlistItemView(house: Preview.dummyHouse)
}
