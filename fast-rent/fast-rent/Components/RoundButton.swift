//
//  RoundButton.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct RoundButton: View {
    
    let imageName: String
    let size: CGFloat
    let imageColor: Color
    
    init(imageName: String, size: CGFloat = 28, imageColor: Color = .white) {
        self.imageName = imageName
        self.size = size
        self.imageColor = imageColor
    }
    
    var body: some View {
        Circle()
            .fill(Color("round-button-color").opacity(0.5))
            .frame(width: size, height: size)
            .overlay(
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 0.4 * size, height: 0.4 * size)
                    .font(.callout.weight(.bold))
                    .foregroundStyle(.white)
            )
    }
}

#Preview {
    RoundButton(imageName: "xmark", size: 20)
}
