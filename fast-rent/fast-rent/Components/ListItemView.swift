//
//  ListItemView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct ListItemView: View {
    
//    let apartment: Apartment
    let house: House
    
    var body: some View {

            VStack {
                // a carousel of images
                ImageCarousel(house: house)
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(house.address)
                            .font(.subheadline)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("\(house.numBedrooms) bedroom - \(house.numBathrooms) bathroom")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("$\(house.price)")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("/ month")
                    }
                }
            }
            .padding()
        }
        
    
}

#Preview {
    ListItemView(house: ExploreViewModel().houses[0])
}
