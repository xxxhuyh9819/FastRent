//
//  Amenity.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/28.
//

import Foundation
import FirebaseFirestoreSwift

struct Amenity: Codable, Identifiable {
    @DocumentID private var amenityId: String?
    var title: String
    var imageName: String
    
    var id: String {
        return amenityId ?? UUID().uuidString
    }
}
