//
//  DataManager.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/28.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase
import OSLog

public class DataManager {
    
    // MARK: - Singleton Stuff
    public static let shared = DataManager()
    
    //This prevents others from using the default '()' initializer
    fileprivate init() {
    }
    let defaults = UserDefaults.standard
    
    
    // MARK: For new models
    
    @MainActor
    func fetchHouses() async throws -> [House] {
        do {
            let snapshot = try await Firestore.firestore().collection("Apartment").getDocuments()
            let apartments = snapshot.documents.compactMap({ try? $0.data(as: House.self) })
            Logger.fetchingFromFirebase.info("Fetched \(apartments.count) houses from Firebase!")
            return apartments
        } catch {
            Logger.fetchingFromFirebase.error("\(error)")
            return []
        }
    }
    
    @MainActor
    func fetchLandlordById(id: String) async throws -> Landlord? {
        do {
            let snapshot = try await Firestore.firestore().collection("Landlord").document(id).getDocument()
            let landlord = try snapshot.data(as: Landlord.self)
            Logger.fetchingFromFirebase.info("Fetched \(landlord.name) from Firebase!")
            return landlord
        } catch {
            Logger.fetchingFromFirebase.error("\(error)")
            return nil
        }
    }
    
    @MainActor
    func fetchAmenities(ids: [String]) async throws -> [Amenity] {
        var amenities = [Amenity]()
        do {
            for id in ids {
                let snapshot = try await Firestore.firestore().collection("Amenity").document(id).getDocument()
                let amenity = try snapshot.data(as: Amenity.self)
                amenities.append(amenity)
            }
            Logger.fetchingFromFirebase.info("Fetched \(amenities.count) amenities from Firebase!")
            return amenities
        } catch {
            Logger.fetchingFromFirebase.error("\(error)")
            return []
        }
    }
}
