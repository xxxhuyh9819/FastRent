//
//  PlaceButton.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct PlaceButton: View {
        
    var body: some View {
        Button {
            
        } label: {
            Image(systemName: "house")
               .symbolRenderingMode(.palette)
               .foregroundStyle(.pink)
        }
    }
}

#Preview {
    PlaceButton()
}
