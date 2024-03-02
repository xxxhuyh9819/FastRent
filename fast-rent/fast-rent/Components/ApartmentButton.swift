//
//  PlaceButton.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

/// An extracted component that is used in MapView
struct ApartmentButton: View {
    
    let house: ConvertedHouse
    
    var body: some View {
        Image(systemName: "house")
            .symbolRenderingMode(.palette)
            .foregroundStyle(.pink)
    }
}

#Preview {
    ApartmentButton(house: Preview.dummyHouse)
}
