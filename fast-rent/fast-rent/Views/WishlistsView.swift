//
//  WishlistsView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct WishlistsView: View {
    
    let wishlist: [Apartment]

    
    var body: some View {
        
        // 2 items per row
        let columns: [GridItem] = [
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(wishlist, id: \.id) { apartment in
                        Text(apartment.address)
                    }
                }
            }
        }
    }
}

#Preview {
    WishlistsView(wishlist: dummyApartments)
}


//NavigationLink{
//    DetailView(apartment: apartment)
//        .navigationBarBackButtonHidden()
//} label: {
//    ListItemView(apartment: apartment)
//        .tint(Color("font-color"))
//}
