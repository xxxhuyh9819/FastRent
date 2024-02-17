//
//  RoundButton.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct RoundButton: View {
    
    let imageName: String
    
    var body: some View {
        Circle()
            .fill(Color("round-button-color"))
            .frame(width: 28, height: 28)
            .overlay(
                Image(systemName: imageName)
                    .imageScale(.small)
                    .font(.callout.weight(.bold))
                    .foregroundStyle(.gray)
            )
    }
}

#Preview {
    RoundButton(imageName: "xmark")
}
