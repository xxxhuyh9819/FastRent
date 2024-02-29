//
//  Database.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/28.
//

import Foundation

final class Database {
    private let FAV_KEY = "fav_key"
    
    func save(items: Set<String>) {
        let array = Array(items)
        UserDefaults.standard.set(array, forKey: FAV_KEY)
    }
    
    func load() -> Set<String> {
        let array = UserDefaults.standard.array(forKey: FAV_KEY) as? [String] ?? [String]()
        print("has \(array.count) items")
        return Set(array)
    }
    
    
    
    func save(items: Set<Demo>) {
        let array = Array(items)
        if let array = try? JSONEncoder().encode(array) {
            UserDefaults.standard.set(array, forKey: FAV_KEY)
        }
    }
    
    func load() -> Set<Demo> {
        if let contentData = UserDefaults.standard.object(forKey: FAV_KEY) as? Data,
            let content = try? JSONDecoder().decode([Demo].self, from: contentData) {
            print(content.count)
            return Set(content)
        }
        return Set<Demo>()
    }
}
