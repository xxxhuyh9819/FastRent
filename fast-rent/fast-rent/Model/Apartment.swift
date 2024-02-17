//
//  Apartment.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import Foundation
import CoreLocation
import SwiftUI

struct Apartment: Hashable {
    let id: String
    var address: String
    var price: Int
    var title: String
    var imageUrls: [String]
    var apartmentName: String
    var numBedrooms: Int
    var numBathrooms: Int
    var description: String
    var latitude: Double
    var longitude: Double
    var amenities: [Amenities]
    var landlord: Landlord
}

enum Amenities {
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

let dummyApartment = Apartment(id: NSUUID().uuidString, address: "1616 E 56th St", price: 2000, title: "1b1b apartment", imageUrls: ["regents-park", "solstice"], apartmentName: "Solstice on the park",  numBedrooms: 1, numBathrooms: 1, description: "A great lake view", latitude: 41.7936, longitude: -87.5859, amenities: [.gym, .laundry, .wifi, .pet], landlord: Landlord(id: NSUUID().uuidString, name: "Alan Smith", avatarUrl: "man-avatar", tel: "8005551212", email: "apple@me.com"))

let dummyApartment1 = Apartment(id: NSUUID().uuidString, address: "1451 E 55th St", price: 2400, title: "2b2b apartment", imageUrls: ["nema-chicago", "solstice"], apartmentName: "UPC",  numBedrooms: 1, numBathrooms: 1, description: "A great lake view", latitude: 41.7953, longitude: -87.5905, amenities: [.gym, .laundry, .wifi, .pet], landlord: Landlord(id: NSUUID().uuidString, name: "Alan Walker", avatarUrl: "man-avatar2", tel: "8005551212", email: "apple@me.com"))

let dummyApartment2 = Apartment(id: NSUUID().uuidString, address: "1210 S Indiana Ave", price: 2700, title: "Luxury 1b1b apartment", imageUrls: ["regents-park", "solstice", "nema-chicago"], apartmentName: "NEMA Chicago",  numBedrooms: 1, numBathrooms: 1, description: "A great lake view", latitude: 41.8670, longitude: -87.6234, amenities: [.gym, .laundry, .wifi, .pet], landlord: Landlord(id: NSUUID().uuidString, name: "John Smith", avatarUrl: "man-avatar3", tel: "8005551212", email: "apple@me.com"))


let dummyApartments = [dummyApartment, dummyApartment1, dummyApartment2]
