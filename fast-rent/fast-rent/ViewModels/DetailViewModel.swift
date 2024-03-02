//
//  DetailViewModel.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/28.
//

import Foundation

/// The  ViewModel  to handle data exclusively belongs to DetailView
class DetailViewModel: ObservableObject {
    let house: ConvertedHouse
    @Published var landlord: Landlord?
    @Published var amenities = [Amenity]()
    
    /// constructor that fetches landlord and amenities of a house upon initialization
    init(house: ConvertedHouse) {
        self.house = house
        Task {
            try await getLandlordById(id: house.landlordId)
            try await getAmenities(ids: house.amenities)
        }
    }
    
    /// A function that calls the function in DataManager to fetch landlord by LandlordID from firebase
    @MainActor
    func getLandlordById(id: String) async throws {
        try await landlord = DataManager.shared.fetchLandlordById(id: id)
    }
    
    /// A function that calls the function in DataManager to fetch amenitied by the IDs  from firebase
    @MainActor
    func getAmenities(ids: [String]) async throws {
        try await amenities = DataManager.shared.fetchAmenities(ids: ids)
    }
}
