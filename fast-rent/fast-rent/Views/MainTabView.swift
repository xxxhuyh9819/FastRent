//
//  TabView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
//            WishlistView(wishlist: dummyApartments)
            Text("Wishlist")
                .tabItem {
                    Label("Wishlists", systemImage: "heart")
                }
        }.tint(.red)
        
    }
}

#Preview {
    MainTabView()
}
