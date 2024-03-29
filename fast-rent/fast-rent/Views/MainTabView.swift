//
//  TabView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

/// The main TabView for the App
struct MainTabView: View {
    var body: some View {
        TabView {
            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
            WishlistView()
                .tabItem {
                    Label("Wishlist", systemImage: "heart")
                }
        }
        .tint(.red)
        
    }
}

#Preview {
    MainTabView()
}
