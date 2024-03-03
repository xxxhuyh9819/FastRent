//
//  WishlistItemView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

/// An extracted view to contain a single House in the Wishlist View
struct WishlistItemView: View {
    
    let house: ConvertedHouse
    
    var body: some View {
//        GeometryReader { geometry in
//            NavigationStack {
//                NavigationLink {
//                    DetailView(house: convertedHouse)
//                        .navigationBarBackButtonHidden()
//                } label: {
//                    VStack(alignment: .leading) {
//                        ImageCarousel(house: convertedHouse)
//                        
//                        VStack(alignment: .leading) {
//                            Text(convertedHouse.title)
//                                .font(.subheadline)
//                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//
//                            Text("$\(convertedHouse.price) / month")
//                                .font(.subheadline)
//                                .fontWeight(.semibold)
//                            Divider()
//                        }
//                        .padding(.leading, 4)
//                        .padding(.bottom)
//                    }
//                    .background(Color(red: 0.9, green: 0.9, blue: 0.9))
//                    .foregroundStyle(Color("font-color"))
//                }
//            }
//        }
//        .clipShape(RoundedRectangle(cornerRadius: 10))
        
        VStack {
            
            ImageCarousel(house: house)
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            HStack {
                VStack(alignment: .leading) {
                    Text("\(house.address), \(house.city)")
                        .font(.subheadline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("\(house.numBedrooms) bedroom - \(house.numBathrooms) bathroom")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                

                Text("$\(house.price)")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
            }
        }
        .padding()
        
    }
}

#Preview {
    WishlistItemView(house: Preview.dummyHouse)
}
