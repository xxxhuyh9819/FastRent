//
//  ExploreViewModel.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/28.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var houses = [House]()
//    @Published var savedItems: Set<String> = []
    @Published var savedItems: Set<Demo> = []
    
    
    init() {
        self.savedItems = fast_rentApp.db.load()
        Task {
            try await getHouses()
        }
    }
    
    @MainActor
    func getHouses() async throws {
        self.houses = try await DataManager.shared.fetchHouses()
    }
    
    
    func contains(_ item: Demo) -> Bool {
//        savedItems.contains(item.title)
        return savedItems.contains(item)
    }
    
    // Toggle saved items
    func toggleFav(item: Demo) {
        if contains(item) {
            savedItems.remove(item)
        } else {
            savedItems.insert(item)
        }
        print("ToggleFav: Has item to save! the set has \(savedItems.count) items!")
        fast_rentApp.db.save(items: savedItems)
    }
}
