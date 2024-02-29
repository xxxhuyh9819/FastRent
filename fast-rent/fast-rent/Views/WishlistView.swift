//
//  WishlistsView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct WishlistView: View {
    
    @StateObject var viewModel = WishlistViewModel()
    
    var favHouses: [Demo] {
        return Array(viewModel.savedItems)
    }

    
    var body: some View {
        
        // 2 items per row
        let columns: [GridItem] = [
                GridItem(),
                GridItem()
            ]
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 2) {
                    ForEach(favHouses, id: \.self) { demo in
                        //                        WishlistItemView(house: house)
                        //                            .frame(width: 160, height: 200)
                        HStack {
                            Text(demo.name)
                            Image(systemName: viewModel.contains(demo) ? "heart.fill" : "heart")
                                .imageScale(.large)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity, maxHeight: .infinity/*@END_MENU_TOKEN@*/,  alignment: .topTrailing)
                                .foregroundStyle(.red)
                                .padding([.top, .trailing])
                                .onTapGesture {
                                    viewModel.toggleFav(demo: demo)
                                }
                                
                        }
                    }
                }
            }
        }
        // refresh the saved items upon entering and leaving the page
        .onAppear() {
            viewModel.savedItems = fast_rentApp.db.load()
        }
        .onDisappear {
            viewModel.savedItems = fast_rentApp.db.load()
        }
    }
}

//#Preview {
//    WishlistView(wishlist: dummyApartments)
//}
