//
//  PlaceButton.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct ApartmentButton: View {
        
    @State private var showPopOver: Bool = false
    let house: House
    
    var body: some View {
        Button {
            showPopOver = true
        } label: {
            Image(systemName: "house")
               .symbolRenderingMode(.palette)
               .foregroundStyle(.pink)
        }
        .popover(isPresented: $showPopOver, attachmentAnchor: .point(.center)) {
            ApartmentPopOverView(house: house)
                .frame(width: 350, height: 320)
                .presentationCompactAdaptation(.popover)
        }
    }
}

#Preview {
    ApartmentButton(house: ExploreViewModel().houses[0])
}
