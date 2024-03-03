//
//  ExploreViewModel.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/28.
//

import Foundation
import SwiftUI
import OSLog

/// The main ViewModel that is used in many views as an environmental object
class MainViewModel: ObservableObject {
    @Published var houses = [House]()
    @Published var savedItems: Set<ConvertedHouse> = []
    
    @Published var location = ""
    @Published var minPrice = ""
    @Published var maxPrice = ""
    @Published var numBathrooms = 0
    @Published var numBedrooms = 0
    
    @Published var didFilter = false
    
    @Published var showSearchView = false
        
    /// A method that filter houses with different filters
    /// Filtering rules: location is required, while price and number of beds/baths are optional
    var filteredHouses: [House] {

        if !showSearchView && !didFilter {
            return houses
        }
        // If the location is empty (entered but cleared), no filter is needed
        if didFilter {
            guard !location.isEmpty else {return houses}
        }
        var result = houses.filter {$0.city.localizedCaseInsensitiveContains(location)}
        
        // If no house satisfies the requirement, then just return the original houses
        if result.isEmpty {
            return houses
        }
        
        // Filter by price range
        result = filterByPrice(listToFilter: &result)
        
        // Filter by number of bedrooms and/or bathrooms
        result = filterByRooms(listToFilter: &result, numOfBeds: numBedrooms, numOfBaths: numBathrooms)
        
        // If no house satisfies the requirement, then just return the original houses
        return result.isEmpty ? houses : result
    }
    
    /// convert House objects to ConvertedHouse objects
    var convertedHouses: [ConvertedHouse] {
        var h = [ConvertedHouse]()
        
        for house in filteredHouses {
            h.append(ConvertedHouse(house: house))
        }
        return h
    }
    
    /// constuctor that loads houses from Firebase and load favorite items from UserDefaults
    init() {
        self.savedItems = fast_rentApp.db.load()
        Task {
            try await getHouses()
        }
    }
    
    /// calls the function at DataManager to load houses from Firebase
    @MainActor
    func getHouses() async throws {
        self.houses = try await DataManager.shared.fetchHouses()
    }
    
    /// Filter houses by price range
    /// Always check if the filtered result is empty before returning. If so, return the original array passed in
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
    
    /// Filter houses by the number of bathrooms and bedrooms with exact match
    /// Always check if the filtered result is empty before returning. If so, return the original array passed in
    func filterByRooms(listToFilter: inout [House], numOfBeds: Int, numOfBaths: Int) -> [House] {
        
        // no input or the input is zero, just return the list passed in
        if (numOfBeds == 0 && numOfBaths == 0) {
            return listToFilter
        }
        
        // only number of bedrooms is entered
        if (numOfBeds != 0 && numOfBaths == 0) {
            listToFilter = listToFilter.filter {$0.numBedrooms == numOfBeds}
            return listToFilter.isEmpty ? houses : listToFilter
        }
        
        // only number of bathrooms is entered
        if (numOfBeds == 0 && numOfBaths != 0) {
            listToFilter = listToFilter.filter {$0.numBathrooms == numOfBaths}
            return listToFilter.isEmpty ? houses : listToFilter
        }
        
        // both number of bedrooms and number of bathroom are entered
        if (numOfBeds != 0 && numOfBaths != 0) {
            listToFilter = listToFilter.filter {$0.numBedrooms == numOfBeds && $0.numBathrooms == numOfBaths}
            return listToFilter.isEmpty ? houses : listToFilter
        }
        
        return listToFilter.isEmpty ? houses : listToFilter
    }
    
    /// A function to check if input is empty
    /// Used for popping alerts when exiting SearchView with inputs left
    func inputNotEmpty() -> Bool {
        return !location.isEmpty || !minPrice.isEmpty || !maxPrice.isEmpty || numBedrooms != 0 || numBathrooms != 0
    }
    
    /// A function to reset all published variables
    /// Used when a search is executed
    func clear() {
        location = ""
        minPrice = ""
        maxPrice = ""
        numBedrooms = 0
        numBathrooms = 0
    }
    
    /// Check if an item is in UserDefaults
    func contains(_ house: ConvertedHouse) -> Bool {
        return savedItems.contains(house)
    }
    
    /// A function to insert/remove an item to UserDefaults
    /// use inout keyword to make savedHouses mutable
    func toggleFavorite(house: ConvertedHouse) {
        if contains(house) {
            // the item is in the set already, need to remove it.
            Logger.localStorage.debug("In \(MainViewModel.self) Start removing \(house.name) from userdefaults...")
            savedItems.remove(house)
        } else {
            // the item is not in the set, need to insert it.
            Logger.localStorage.debug("In \(MainViewModel.self) Start inserting \(house.name) to userdefaults...")
            savedItems.insert(house)
        }
        // Save the update to UserDefaults
        fast_rentApp.db.save(items: savedItems)
    }
}
