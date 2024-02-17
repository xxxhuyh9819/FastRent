//
//  ApartmentPopOverView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct ApartmentPopOverView: View {
    
    let apartment: Apartment
    
    var body: some View {
        Text(apartment.address)
    }
}

#Preview {
    ApartmentPopOverView(apartment: dummyApartments[0])
}
