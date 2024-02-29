//
//  ExploreViewModel.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/28.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var houses = [House]()
    @Published var savedItems: Set<ConvertedHouse> = []
    
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
}
