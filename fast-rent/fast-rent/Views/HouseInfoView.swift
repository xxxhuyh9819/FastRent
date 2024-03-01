//
//  HouseInfoView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/3/1.
//

import SwiftUI

struct HouseInfoView: View {
    
    let house: ConvertedHouse    
    @Binding var showInfo: Bool
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            Image(house.imageUrls[0])
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 120)
                .padding(.trailing, 20)
            
            Spacer()
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("\(house.city), \(house.state)")
                    Spacer()
                    
                    FavoriteButton(house: house, imageName: fast_rentApp.db.contains(house, viewModel.savedItems) ? "heart.fill" : "heart", size: 18)
                        .onTapGesture {
                            fast_rentApp.db.toggleFav(convertedHouse: house, savedHouses: &viewModel.savedItems)
                        }
                }
                
                Spacer()
                
                HStack {
                    Text("$\(house.price)")
                        .fontWeight(.semibold)
                }
            }
            .foregroundStyle(.black)
            .padding()
            .padding(.leading, 8)
        }
        .overlay {
            RoundButton(imageName: "xmark", size: 20)
                .onTapGesture {
                    withAnimation(.spring) {
                        showInfo.toggle()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding([.top, .leading])
        }
        .frame(height: 120)
        .font(.subheadline)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
        .padding(.bottom, 20)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

#Preview {
    HouseInfoView(house: ConvertedHouse(house: Preview.dummyApartment), showInfo: .constant(true))
}
