//
//  WishlistsView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI
import OSLog

struct WishlistView: View {
    
    @EnvironmentObject var rootViewModel: MainViewModel
    
    var body: some View {
        
        
            NavigationStack {
                VStack {
                    if (rootViewModel.savedItems.isEmpty) {
                        withAnimation(.spring) {
                            EmptyWishlistView()
                        }
                    } else {
                        ScrollView {
                            LazyVStack() {
                                ForEach(rootViewModel.savedItems.sorted {$0.price < $1.price} ) { house in
                                    NavigationLink {
                                        DetailView(house: house)
                                            .navigationBarBackButtonHidden()
                                    } label: {
                                        WishlistItemView(house: house)
                                            .tint(Color("font-color"))
                                    }
                                }
                            }
                            .padding(.top)
                        }
                        
                    }
                }
                .navigationTitle("Wishlist")
                .navigationBarTitleDisplayMode(.inline)
                
            }
            
        
    }
}

#Preview {
    WishlistView()
}
