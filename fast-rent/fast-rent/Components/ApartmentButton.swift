//
//  PlaceButton.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct ApartmentButton: View {
        
    @State private var showPopOver: Bool = false
    let apartment: Apartment
    
    var body: some View {
        Button {
            showPopOver = true
        } label: {
            Image(systemName: "house")
               .symbolRenderingMode(.palette)
               .foregroundStyle(.pink)
        }
        .popover(isPresented: $showPopOver, attachmentAnchor: .point(.center)) {
            ApartmentPopOverView(apartment: apartment)
                .frame(height: 400)
                .presentationCompactAdaptation(.popover)
        }
    }
}

#Preview {
    ApartmentButton(apartment: dummyApartments[0])
}
