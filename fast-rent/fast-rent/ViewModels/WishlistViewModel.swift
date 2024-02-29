//
//  WishlistViewModel.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/28.
//

import Foundation

class WishlistViewModel: ObservableObject {
    
    @Published var savedItems: Set<ConvertedHouse> = []

    init() {
        self.savedItems = fast_rentApp.db.load()
    }
}
