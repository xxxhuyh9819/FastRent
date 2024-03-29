//
//  Apartment.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import Foundation
import CoreLocation
import FirebaseFirestoreSwift


/// the house model that is used by Firebase
/// @DocumentID is a macro from FirebaseFirestoreSwift,
/// Allows using the randomly generated ID at firestore as the object's ID
struct House: Codable, Identifiable, Hashable {
    @DocumentID private var houseId: String?
    var name: String
    var address: String
    var city: String
    var state: String
    var price: Int
    var title: String
    var imageUrls: [String]
    var numBedrooms: Int
    var numBathrooms: Int
    var description: String
    var latitude: Double
    var longitude: Double
    
    // use the ID of the landlord to find the landlord that owns the house
    var landlordId: String
    var amenities: [String]
    
    var id: String {
        return houseId ?? UUID().uuidString
    }
}


/// The model used by UserDefaults  to bypass the problem with encoding and decoding Firebase related objects
struct ConvertedHouse: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var address: String
    var city: String
    var state: String
    var price: Int
    var title: String
    var imageUrls: [String]
    var numBedrooms: Int
    var numBathrooms: Int
    var description: String
    var latitude: Double
    var longitude: Double
    var landlordId: String
    var amenities: [String]
    
    /// constructor that converts a House object to a ConvertedHouse one
    init(house: House) {
        self.id = house.id
        self.name = house.name
        self.address = house.address
        self.city = house.city
        self.state = house.state
        self.price = house.price
        self.title = house.title
        self.imageUrls = house.imageUrls
        self.numBedrooms = house.numBedrooms
        self.numBathrooms = house.numBathrooms
        self.description = house.description
        self.latitude = house.latitude
        self.longitude = house.longitude
        self.landlordId = house.landlordId
        self.amenities = house.amenities
    }
}
