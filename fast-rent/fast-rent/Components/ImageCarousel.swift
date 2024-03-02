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
    
    var body: some View {
        // if there is no image for the house, show the prepared placeholder.
        // if there is image for the house, show the carousel.
        if (house.imageUrls.isEmpty) {
            Image(systemName: "photo")
        } else {
            TabView {
                ForEach(house.imageUrls, id: \.self) { url in
                    Image(url)
                        .resizable()
                        .scaledToFill()
                }
            }
            .tabViewStyle(.page)
        }
        
    }
}

#Preview {
    ImageCarousel(house: Preview.dummyHouse)
}
