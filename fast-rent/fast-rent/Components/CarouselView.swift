//
//  CarouselView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct CarouselView: View {
    
    let apartment: Apartment
    
    var body: some View {
        // a carousel of photos
        TabView {
            ForEach(apartment.imageUrls, id: \.self) { photo in
                Image(photo)
                    .resizable()
                    .scaledToFill()
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    CarouselView(apartment: dummyApartments[0])
}
