//
//  CarouselView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct ImageCarousel: View {
    
    let house: ConvertedHouse
    
    var body: some View {
        // a carousel of photos
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

#Preview {
    ImageCarousel(house: ConvertedHouse(house: Preview.dummyApartment))
}
