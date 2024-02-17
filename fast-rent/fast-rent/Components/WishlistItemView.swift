//
//  WishlistItemView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct WishlistItemView: View {
    
    let apartment: Apartment
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Image(apartment.imageUrls[0])
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width + 10, height: 100)
                VStack(alignment: .leading) {
                    Text(apartment.title)
                        .font(.headline)
                    Text("\(apartment.numBedrooms) bedroom - \(apartment.numBathrooms) bathroom")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    Text("$\(apartment.price) / month")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .padding(.bottom)
            }
            .overlay {
                Rectangle()
                    .stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.black)
                    .frame(width: geometry.size.width + 10)
                    .shadow(radius: 5)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        
    }
}

#Preview {
    WishlistItemView(apartment: dummyApartments[0])
}
