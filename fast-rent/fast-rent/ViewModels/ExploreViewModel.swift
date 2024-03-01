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
    @Published var location = ""
    @Published var minPrice = ""
    @Published var maxPrice = ""
    
    var housesCopy = [House]()
    
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
    
    
    /* Has to go through city first
       Th
     */
    
    func filterHouses() {
        
        let priceRange: [String: Int] = ["min": Int(minPrice) ?? 0, "max": Int(maxPrice) ?? Int.max]
        print("min: \(priceRange["min"]!), max: \(priceRange["max"]!)")
        
        let trimmed = location.trimmingCharacters(in: .whitespacesAndNewlines)
        let filteredHouses = houses.filter({
            $0.city.lowercased() == trimmed.lowercased() || $0.state.lowercased() == trimmed.lowercased()
        })
        // if search a city that doesn't not exist, just give a default listing that contains everything
        if (filteredHouses.isEmpty) {
            print("There is no such city!")
            self.houses = housesCopy
            return
        }
        if (priceRange["min"] == 0 && priceRange["max"] == Int.max) {
            self.houses = filteredHouses
            print("there are \(self.houses.count) results!")
            return
        }
        if (priceRange["min"] != 0 && priceRange["max"] == Int.max) {
            self.houses = filteredHouses.filter({
                $0.price >= priceRange["min"]!
            })
            print("there are \(self.houses.count) results!")
            return
        }
        if (priceRange["min"] == 0 && priceRange["max"] != Int.max) {
            self.houses = filteredHouses.filter({
                $0.price <= priceRange["max"]!
            })
            print("there are \(self.houses.count) results!")
            return
        }
        self.houses = filteredHouses.filter({
            $0.price >= priceRange["min"]! && $0.price <= priceRange["max"]!
        })
        print("there are \(self.houses.count) results!")
        return
    }
    
    
    
    func clear() {
        location = ""
        minPrice = ""
        maxPrice = ""
    }
}
