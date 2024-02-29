//
//  DetailViewModel.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/28.
//

import Foundation

class DetailViewModel: ObservableObject {
    let house: ConvertedHouse
    @Published var landlord: Landlord?
    @Published var amenities = [Amenity]()
    
    init(house: ConvertedHouse) {
        self.house = house
        Task {
            try await getLandlordById(id: house.landlordId)
            try await getAmenities(ids: house.amenities)
        }
    }
    
    @MainActor
    func getLandlordById(id: String) async throws {
        try await landlord = DataManager.shared.fetchLandlordById(id: id)
    }
    
    @MainActor
    func getAmenities(ids: [String]) async throws {
        try await amenities = DataManager.shared.fetchAmenities(ids: ids)
    }
}
