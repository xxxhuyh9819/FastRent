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
    @Published var didFilter = false
    @Published var numBathrooms = 0
    @Published var numBedrooms = 0
    
    @Published var showSearchView = false
    
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
//        result = filterByRooms(listToFilter: &result, numOfBeds: Int(numBedrooms) ?? 0, numOfBaths: Int(numBathrooms) ?? 0)
        result = filterByRooms(listToFilter: &result, numOfBeds: numBedrooms, numOfBaths: numBathrooms)
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
    
    
    func filterByPrice(listToFilter: inout [House]) -> [House] {
        // no input in both, no filtering is needed, just return the list passed in
        if (Int(minPrice) ?? 0 == 0 && Int(maxPrice) ?? Int.max == Int.max) {
            return listToFilter
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
    
    // filter by exact match
    func filterByRooms(listToFilter: inout [House], numOfBeds: Int, numOfBaths: Int) -> [House] {
        // no input or the input is zero, just return the list passed in
        if (numOfBeds == 0 && numOfBaths == 0) {
            return listToFilter
        }
        
        if (numOfBeds != 0 && numOfBaths == 0) {
            listToFilter = listToFilter.filter {$0.numBedrooms == numOfBeds}
            return listToFilter.isEmpty ? houses : listToFilter
        }
        
        if (numOfBeds == 0 && numOfBaths != 0) {
            listToFilter = listToFilter.filter {$0.numBathrooms == numOfBaths}
            return listToFilter.isEmpty ? houses : listToFilter
        }
        
        if (numOfBeds != 0 && numOfBaths != 0) {
            listToFilter = listToFilter.filter {$0.numBedrooms == numOfBeds && $0.numBathrooms == numOfBaths}
            return listToFilter.isEmpty ? houses : listToFilter
        }
        
        return listToFilter.isEmpty ? houses : listToFilter
    }
    
    
    func inputNotEmpty() -> Bool {
        return !location.isEmpty || !minPrice.isEmpty || !maxPrice.isEmpty || numBedrooms != 0 || numBathrooms != 0
    }
    
    func clear() {
        location = ""
        minPrice = ""
        maxPrice = ""
        numBedrooms = 0
        numBathrooms = 0
    }
}
