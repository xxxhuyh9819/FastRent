//
//  ApartmentPopOverView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct ApartmentPopOverView: View {
    
    let apartment: Apartment
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(apartment.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    
                Spacer()
                
                Circle()
                    .fill(Color(uiColor: .tertiarySystemFill))
                    .frame(width: 30, height: 30)
                    .overlay(
                        Image(systemName: "xmark")
                            .imageScale(.small)
                            .font(.callout.weight(.bold))
                            .foregroundColor(.secondary)
                    )
                    .onTapGesture {
                        dismiss()
                    }
            }
            
            Text(apartment.address)
                .font(.subheadline)
                .fontWeight(.semibold)
            Text("$\(apartment.price) / month")
                .font(.subheadline)
                .fontWeight(.bold)
            GeometryReader { geometry in
                ImageCarousel(apartment: apartment)
                    .frame(width: geometry.size.width)
                    .cornerRadius(10)
            }
        }
        .padding()
        
    }
}

#Preview {
    ApartmentPopOverView(apartment: dummyApartments[0])
}
