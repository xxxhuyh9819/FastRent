//
//  FavoriteButton.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/28.
//

import SwiftUI

struct FavoriteButton: View {
    
    let house: ConvertedHouse
    var imageName: String
    var size: CGFloat
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .frame(width: size)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity, maxHeight: .infinity/*@END_MENU_TOKEN@*/,  alignment: .topTrailing)
            .padding([.top, .trailing])
            .foregroundStyle(.red)
    }
}

#Preview {
    FavoriteButton(house: ConvertedHouse(house: Preview.dummyApartment), imageName: "heart", size: 20)
}
