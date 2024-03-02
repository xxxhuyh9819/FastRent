//
//  FavoriteButton.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/28.
//

import SwiftUI

/// An extracted view to toggle whether a house is added to the wish list
struct FavoriteButton: View {
    
    let house: ConvertedHouse
    var imageName: String
    var size: CGFloat
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .frame(width: size)
            .foregroundStyle(.red)
    }
}

#Preview {
    FavoriteButton(house: Preview.dummyHouse, imageName: "heart", size: 20)
}
