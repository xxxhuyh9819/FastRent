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
}
