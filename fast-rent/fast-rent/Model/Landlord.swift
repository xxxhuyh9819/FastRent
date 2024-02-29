//
//  Landlord.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import Foundation
import FirebaseFirestoreSwift


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
