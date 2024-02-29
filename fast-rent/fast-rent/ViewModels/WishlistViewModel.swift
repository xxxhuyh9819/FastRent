//
//  WishlistViewModel.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/28.
//

import Foundation

class WishlistViewModel: ObservableObject {
    
    @Published var savedItems: Set<String> = []
    
    
    init() {
        self.savedItems = fast_rentApp.db.load()
    }
    
    func contains(_ name: String) -> Bool {
        savedItems.contains(name)
    }
    
    // Toggle saved items
    func toggleFav(name: String) {
        if contains(name) {
            savedItems.remove(name)
        } else {
            savedItems.insert(name)
        }
        print("ToggleFav: Has item to save! the set has \(savedItems.count) items!")
        fast_rentApp.db.save(items: savedItems)
    }
    
}
