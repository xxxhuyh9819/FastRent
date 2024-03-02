//
//  Preview.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/28.
//

import Foundation

/// Dummy data for preview
public struct Preview {
    static let dummyApartment = House(name: "Dummy Apartment", address: "1210 S Indiana Ave", city: "Chicago", state: "IL", price: 2000, title: "1B1B apartment", imageUrls: ["nema-chicago", "regents-park"], numBedrooms: 1, numBathrooms: 1, description: "A great lake view", latitude: 41.8670, longitude: -87.6234, landlordId: "1", amenities: ["1"])
    static let dummyHouse = ConvertedHouse(house: dummyApartment)
}
