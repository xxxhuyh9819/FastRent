//
//  Database.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/28.
//

import Foundation

final class Database {
    private let FAV_KEY = "fav_key"
    
    /// Encode the Set of ConvertedHouse objects and save it into UserDefaults
    func save(items: Set<ConvertedHouse>) {
        let array = Array(items)
        if let array = try? JSONEncoder().encode(array) {
            UserDefaults.standard.set(array, forKey: FAV_KEY)
        }
    }
    
    /// Get data from UserDefaults and decode it into a Set of ConvertedHouse objects
    func load() -> Set<ConvertedHouse> {
        if let contentData = UserDefaults.standard.object(forKey: FAV_KEY) as? Data,
            let content = try? JSONDecoder().decode([ConvertedHouse].self, from: contentData) {
            return Set(content)
        }
        return Set<ConvertedHouse>()
    }
    
    /// Check if an item is in UserDefaults
    func contains(_ house: ConvertedHouse, _ items: Set<ConvertedHouse>) -> Bool {
        return items.contains(house)
    }
    
    // src: https://stackoverflow.com/questions/24451959/mutate-function-parameters-in-swift
    /// A function to insert/remove an item to UserDefaults
    /// use inout keyword to make savedHouses mutable
    func toggleFavorite(convertedHouse: ConvertedHouse, savedHouses: inout Set<ConvertedHouse>) {
        if contains(convertedHouse, savedHouses) {
            // the item is in the set already, need to remove it.
            savedHouses.remove(convertedHouse)
        } else {
            // the item is not in the set, need to insert it.
            savedHouses.insert(convertedHouse)
        }
        // Save the update to UserDefaults
        save(items: savedHouses)
    }
}
