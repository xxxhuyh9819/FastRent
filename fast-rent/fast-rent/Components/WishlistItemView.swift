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
    
    // a state variable that determines whether the user is deleting an item from wishlist
    // if true, an alert will show up
    @State var isDeleting = false
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 10)
            .fill(.appBackground)
            .frame(height: 300)

            .shadow(color: .shadow , radius: 5)
            .overlay {
                ZStack {
                    VStack {
                        ImageCarousel(house: house, isForWishlist: true)
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
                        .padding()
                    }
                    
                    FavoriteButton(house: house, imageName: rootViewModel.contains(house) ? "heart.fill" : "heart", size: 24)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding([.top, .trailing], 16)
                        .onTapGesture {
                            if (rootViewModel.contains(house)) {
                                withAnimation(.spring) {
                                    Logger.localStorage.info("In \(WishlistItemView.self): Planning to delete \(house.name) from wishlist...")
                                    isDeleting = true
                                }
                            } else {
                                withAnimation(.spring) {
                                    rootViewModel.toggleFavorite(house: house)
                                }
                            }
                        }
                    // show an alert after clicking the wishlist icon
                        .alert("Remove from wishlist?", isPresented: $isDeleting) {
                            Button("Remove", role: .destructive) {
                                withAnimation(.spring) {
                                    Logger.localStorage.info("In \(WishlistItemView.self): Starting to delete \(house.name) from wishlist...")
                                    rootViewModel.toggleFavorite(house: house)
                                    isDeleting = false
                                }
                            }
                            Button("Cancel", role: .cancel) {
                                isDeleting = false
                            }
                        } message: {
                            Text("\"\(house.name)\" will be permanently deleted.")
                        }
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))

            }
            .padding()
            
    }
}

#Preview {
    WishlistItemView(house: Preview.dummyHouse)
}
