//
//  WishlistItemView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct WishlistItemView: View {
    
    let convertedHouse: ConvertedHouse
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                NavigationLink {
                    DetailView(house: convertedHouse)
                        .navigationBarBackButtonHidden()
                } label: {
                    VStack(alignment: .leading) {
                        Image(convertedHouse.imageUrls[0])
                            .resizable()
                            .scaledToFill()
                        
                        VStack(alignment: .leading) {
                            Text(convertedHouse.title)
                                .font(.subheadline)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)

                            Text("$\(convertedHouse.price) / month")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Divider()
                        }
                        .padding(.leading, 4)
                        .padding(.bottom)
                    }
                    .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                    .foregroundStyle(Color("font-color"))
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        
    }
}

//#Preview {
//    WishlistItemView(apartment: dummyApartments[0])
//}
