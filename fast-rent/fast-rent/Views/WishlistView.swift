//
//  WishlistsView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct WishlistView: View {
    
    let wishlist: [Apartment]

    
    var body: some View {
        
        // 2 items per row
        let columns: [GridItem] = [
                GridItem(),
                GridItem()
            ]
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 2) {
                    ForEach(wishlist, id: \.id) { apartment in
                        WishlistItemView(apartment: apartment)
                            .frame(width: 160, height: 200)
                    }
                }
            }
        }
    }
}

#Preview {
    WishlistView(wishlist: dummyApartments)
}
