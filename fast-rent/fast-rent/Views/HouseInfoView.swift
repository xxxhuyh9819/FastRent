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
    @State var isDeleting = false
    
    var body: some View {
        
        NavigationStack {
            NavigationLink {
                DetailView(house: house)
                    .navigationBarBackButtonHidden()
            } label: {
                HStack(alignment: .top) {
                    Rectangle()
                    .fill(.clear)
                        .frame(width: 100)
                        .overlay {
                            Image(house.imageUrls[0])
                                .resizable()
                        }
                        .overlay {
                            RoundButton(imageName: "xmark", size: 24)
                                .onTapGesture {
                                    withAnimation(.spring) {
                                        showInfo.toggle()
                                    }
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .padding()

                        }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(house.name)")
                                    .fontWeight(.semibold)
                                Text("\(house.city), \(house.state)")
                                    .font(.footnote)
                            }
                            Spacer()
                            
                            FavoriteButton(house: house, imageName: fast_rentApp.db.contains(house, viewModel.savedItems) ? "heart.fill" : "heart", size: 20)
                                .onTapGesture {
                                    if (fast_rentApp.db.contains(house, viewModel.savedItems)) {
                                        isDeleting = true
                                    } else {
                                        fast_rentApp.db.toggleFavorite(convertedHouse: house, savedHouses: &viewModel.savedItems)
                                    }
                                }
                            // show an alert after clicking the wishlist icon
                                .alert("Remove from wishlist?", isPresented: $isDeleting) {
                                    Button("Remove", role: .destructive) {
                                        fast_rentApp.db.toggleFavorite(convertedHouse: house, savedHouses: &viewModel.savedItems)
                                        isDeleting = false
                                    }
                                    Button("Cancel", role: .cancel) {
                                        isDeleting = false
                                    }
                                } message: {
                                    Text("\"\(house.title)\" will be permanently deleted.")
                                }
                        }
                        
                        Spacer()
                        
                        HStack {
                            Text("$\(house.price)")
                                .fontWeight(.semibold)
                        }
                    }
                    .padding(.vertical)
                    .foregroundStyle(.font)
                    
                    Spacer()
                }
            }
        }
        .frame(height: 100)
        .font(.subheadline)
        .background(.appBackground)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
        .padding(.bottom, 20)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
        
}

#Preview {
    HouseInfoView(house: ConvertedHouse(house: Preview.dummyApartment), showInfo: .constant(true))
}
