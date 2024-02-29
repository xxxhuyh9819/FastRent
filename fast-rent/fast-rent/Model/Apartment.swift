//
//  Apartment.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import Foundation
import CoreLocation
import SwiftUI
import FirebaseFirestoreSwift


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
    var landlordId: String
    var amenities: [String]
    
    var id: String {
        return houseId ?? UUID().uuidString
    }
}

enum Amenities: Int, CaseIterable, Codable {
    case gym
    case laundry
    case parking
    case wifi
    case pet
    case airConditioning
    
    var title: String {
        switch self {
        case .gym:
            return "Gym"
        case .laundry:
            return "Laundry"
        case .parking:
            return "Parking"
        case .wifi:
            return "Wifi"
        case .pet:
            return "Pet Friendly"
        case .airConditioning:
            return "Air Conditioning"
        }
    }
    
    var imageName: String {
        switch self {
        case .gym:
            return "dumbbell"
        case .laundry:
            return "washer"
        case .parking:
            return "parkingsign.circle.fill"
        case .wifi:
            return "wifi"
        case .pet:
            return "pawprint.fill"
        case .airConditioning:
            return "air.conditioner.horizontal.fill"
        }
    }
}


//let dummyApartment2 = Apartment(id: NSUUID().uuidString, address: "1210 S Indiana Ave", price: 2700, title: "Luxury 1b1b apartment", imageUrls: ["regents-park", "solstice", "nema-chicago"], apartmentName: "NEMA Chicago",  numBedrooms: 1, numBathrooms: 1, description: "A great lake view", latitude: 41.8670, longitude: -87.6234, amenities: [.gym, .laundry, .wifi, .pet], landlord: Landlord(name: "John Smith", avatarUrl: "man-avatar3", tel: "8005551212", email: "apple@me.com"))
