//
//  ExploreViewModel.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/28.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var houses = [House]()
    @Published var savedItems: Set<ConvertedHouse> = []
    @Published var location = ""
    @Published var minPrice = ""
    @Published var maxPrice = ""
    @Published var showSearchView = false
    @Published var didFilter = false
    
    var housesCopy = [House]()
    
    var filteredHouses: [House] {
        if !showSearchView && !didFilter {
            return houses
        }
        if didFilter {
            guard !location.isEmpty else {return houses}
        }
        var result = houses.filter {$0.city.localizedCaseInsensitiveContains(location)}
        if result.isEmpty {
            return houses
        }
        
        result = filterByPrice(listToFilter: &result)
        return result.isEmpty ? houses : result
        
    }
    
    init() {
        self.savedItems = fast_rentApp.db.load()
        Task {
            try await getHouses()
            housesCopy = houses
        }
    }
    
    @MainActor
    func getHouses() async throws {
        self.houses = try await DataManager.shared.fetchHouses()
    }
    
    func filterHousesByLocation() {
        let trimmed = location.trimmingCharacters(in: .whitespacesAndNewlines)
        let filteredHouses = houses.filter({
            $0.city.lowercased() == trimmed.lowercased() || $0.state.lowercased() == trimmed.lowercased()
        })
        
        // if search a city that doesn't not exist, just give a default listing that contains everything
        self.houses = filteredHouses.isEmpty ? housesCopy : filteredHouses
        print("Houses filtered by location! there are \(filteredHouses.count) results!")
    }
    
    func filterByPrice(listToFilter: inout [House]) -> [House] {
        // no input in both, do nothing
        if (Int(minPrice) ?? 0 == 0 && Int(maxPrice) ?? Int.max == Int.max) {
            return listToFilter.isEmpty ? houses : listToFilter
        }
        
        // only min value entered
        if (Int(minPrice) ?? 0 != 0 && Int(maxPrice) ?? Int.max == Int.max) {
            listToFilter = listToFilter.filter {$0.price >= Int(minPrice)!}
            return listToFilter.isEmpty ? houses : listToFilter
        }
        
        // only max value entered
        if (Int(minPrice) ?? 0 == 0 && Int(maxPrice) ?? Int.max != Int.max) {
            listToFilter = listToFilter.filter {$0.price <= Int(maxPrice)!}
            return listToFilter.isEmpty ? houses : listToFilter
        }
        
        // both values entered
        if (Int(minPrice) ?? 0 != 0 && Int(maxPrice) ?? Int.max != Int.max) {
            listToFilter = listToFilter.filter {$0.price >= Int(minPrice)! && $0.price <= Int(maxPrice)!}
        }
        return listToFilter.isEmpty ? houses : listToFilter
    }
    
    func inputNotEmpty() -> Bool {
        return !location.isEmpty || !minPrice.isEmpty || !maxPrice.isEmpty
    }
    
    func clear() {
        location = ""
        minPrice = ""
        maxPrice = ""
    }
}
