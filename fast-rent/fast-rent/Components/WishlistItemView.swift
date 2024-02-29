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
//                    DetailView(apartment: apartment)
                    Text("hahaha")
//                        .navigationBarBackButtonHidden()
                } label: {
                    VStack(alignment: .leading) {
                        Image(convertedHouse.imageUrls[0])
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width + 10)
                        
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
                    .foregroundStyle(Color("font-color"))
                    .overlay {
                        Rectangle()
                            .foregroundStyle(.black.opacity(0.8))
                            .frame(width: geometry.size.width + 10, height: geometry.size.height + 10)
                            .shadow(color: .black, radius: 100)
                    }
                }
                
            }
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        
    }
}

//#Preview {
//    WishlistItemView(apartment: dummyApartments[0])
//}
