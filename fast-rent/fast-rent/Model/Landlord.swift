//
//  Landlord.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import Foundation
import FirebaseFirestoreSwift

/// the landlord model that is used by Firebase
/// @DocumentID is a macro from FirebaseFirestoreSwift,
/// Allows using the randomly generated ID at firestore as the object's ID
struct Landlord : Hashable, Codable {
    @DocumentID private var landlordId: String?
    
    var name: String
    var avatarUrl: String
    var tel: String
    var email: String
    
    var id: String {
        return landlordId ?? UUID().uuidString
    }
}
