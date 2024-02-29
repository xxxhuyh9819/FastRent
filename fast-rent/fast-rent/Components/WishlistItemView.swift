//
//  WishlistItemView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct WishlistItemView: View {
    
    let house: House
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                NavigationLink {
//                    DetailView(apartment: apartment)
//                        .navigationBarBackButtonHidden()
                } label: {
                    VStack(alignment: .leading) {
                        Image(house.imageUrls[0])
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width + 10)
                        
                        VStack(alignment: .leading) {
                            Text(house.title)
                                .font(.subheadline)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            HStack {
                                Text("\(house.numBedrooms)")
                                Image(systemName: "bed.double")
                                    .imageScale(.small)
                                Text("-")
                                Text("\(house.numBathrooms)")
                                    .imageScale(.small)
                                Image(systemName: "shower")
                            }
                            .font(.footnote)
                            .fontWeight(.semibold)

                            Text("$\(house.price) / month")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Divider()
                        }
                        .padding(.leading, 4)
                        .padding(.bottom)
                    }
                    .foregroundStyle(Color("font-color"))
                    .overlay {
                        Rectangle()
                            .foregroundStyle(.white.opacity(0))
                            .frame(width: geometry.size.width + 10, height: geometry.size.height + 10)
                            .shadow(radius: 20)
                    }
                }
                
            }
            .navigationTitle("Wishlist")
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        
    }
}

//#Preview {
//    WishlistItemView(apartment: dummyApartments[0])
//}
