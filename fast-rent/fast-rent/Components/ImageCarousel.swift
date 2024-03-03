//
//  CarouselView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

/// An extracted view to contain pictures of Houses
struct ImageCarousel: View {
    
    let house: ConvertedHouse
    
    // if there is no image for the house, return an array with the prepared placeholder.
    // if there is image for the house, return the imageUrls itself
    var urls: [String] {
        return house.imageUrls.isEmpty ? ["NoImagePlaceHolder"] : house.imageUrls
    }
    
    var isForWishlist: Bool
    
    init(house: ConvertedHouse, isForWishlist: Bool = false) {
        self.house = house
        self.isForWishlist = isForWishlist
    }
    
    var body: some View {
        TabView {
            ForEach(isForWishlist ? [urls[0]] : urls, id: \.self) { url in
                Image(url)
                    .resizable()
                    .scaledToFill()
            }
        }
        .tabViewStyle(.page)
    
        
    }
}

#Preview {
    ImageCarousel(house: Preview.dummyHouse)
}
