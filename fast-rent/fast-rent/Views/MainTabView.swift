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
            WishlistView()
                .tabItem {
                    Label("Wishlist", systemImage: "heart.fill")
                }
        }
        
        .tint(.red)
        
    }
}

#Preview {
    MainTabView()
}
