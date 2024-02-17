//
//  ListItemView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct ListItemView: View {
    
    let apartment: Apartment
    
    var body: some View {
        VStack {
            // a carousel of images
            ImageCarousel(apartment: apartment)
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            HStack {
                VStack(alignment: .leading) {
                    Text(apartment.address)
                        .font(.subheadline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("\(apartment.numBedrooms) bedroom - \(apartment.numBathrooms) bathroom")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                HStack {
                    Text("$\(apartment.price)")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("/ month")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ListItemView(apartment: dummyApartment)
}
