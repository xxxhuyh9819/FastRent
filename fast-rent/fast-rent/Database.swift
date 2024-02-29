//
//  Database.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/28.
//

import Foundation

final class Database {
    private let FAV_KEY = "fav_key"
    
    func save(items: Set<ConvertedHouse>) {
        let array = Array(items)
        if let array = try? JSONEncoder().encode(array) {
            UserDefaults.standard.set(array, forKey: FAV_KEY)
        }
    }
    
    func load() -> Set<ConvertedHouse> {
        if let contentData = UserDefaults.standard.object(forKey: FAV_KEY) as? Data,
            let content = try? JSONDecoder().decode([ConvertedHouse].self, from: contentData) {
            return Set(content)
        }
        return Set<ConvertedHouse>()
    }
    
    
    func contains(_ house: ConvertedHouse, _ items: Set<ConvertedHouse>) -> Bool {
        return items.contains(house)
    }
    
    // src: https://stackoverflow.com/questions/24451959/mutate-function-parameters-in-swift
    func toggleFav(convertedHouse: ConvertedHouse, savedHouses: inout Set<ConvertedHouse>) {
        if contains(convertedHouse, savedHouses) {
            savedHouses.remove(convertedHouse)
        } else {
            savedHouses.insert(convertedHouse)
        }
        print("ToggleFav: Has item to save! the set has \(savedHouses.count) items!")
        save(items: savedHouses)
    }
}
