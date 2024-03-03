//
//  WarningView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/3/3.
//

import SwiftUI

struct WarningView: View {
    
    @Binding var isDeleting: Bool
    let house: ConvertedHouse
    
    var body: some View {
        Rectangle()
            .frame(width: 200)
            .overlay {
                VStack {
                    Text("Remove from wishlist?")
                        .fontWeight(.semibold)
                    Text("\(house.name) will be permanently deleted.")
                        .font(.footnote)
                    
                    HStack {
                        
                    }
                }
            }
    }
}

#Preview {
    WarningView(isDeleting: .constant(false), house: Preview.dummyHouse)
}
