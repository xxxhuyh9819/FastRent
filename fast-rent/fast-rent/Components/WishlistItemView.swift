//
//  WishlistItemView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

/// An extracted view to contain a single House in the Wishlist View
struct WishlistItemView: View {
    
    let house: ConvertedHouse
    
    var body: some View {
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
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
            }
        }
        .padding()
        
    }
}

#Preview {
    WishlistItemView(house: Preview.dummyHouse)
}
