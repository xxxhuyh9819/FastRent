//
//  Amenity.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/28.
//

import Foundation
import FirebaseFirestoreSwift

/// the amenity model 
/// @DocumentID is a macro from FirebaseFirestoreSwift,
/// Allows using the randomly generated ID at firestore as the object's ID
struct Amenity: Codable, Identifiable {
    @DocumentID private var amenityId: String?
    var title: String
    var imageName: String
    
    var id: String {
        return amenityId ?? UUID().uuidString
    }
}
