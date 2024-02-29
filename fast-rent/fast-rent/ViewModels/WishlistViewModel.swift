//
//  WishlistViewModel.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/28.
//

import Foundation

class WishlistViewModel: ObservableObject {
    
//    @Published var savedItems: Set<String> = []
    @Published var savedItems: Set<Demo> = []

    
    
    init() {
        self.savedItems = fast_rentApp.db.load()
    }
    
    func contains(_ name: Demo) -> Bool {
        savedItems.contains(name)
    }
    
    // Toggle saved items
    func toggleFav(demo: Demo) {
        if contains(demo) {
            savedItems.remove(demo)
        } else {
            savedItems.insert(demo)
        }
        print("ToggleFav: Has item to save! the set has \(savedItems.count) items!")
        fast_rentApp.db.save(items: savedItems)
    }
}
