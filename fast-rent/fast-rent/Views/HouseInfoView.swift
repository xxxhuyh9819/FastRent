//
//  HouseInfoView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/3/1.
//

import SwiftUI
import OSLog

struct HouseInfoView: View {
    
    let house: ConvertedHouse    
    @Binding var showInfo: Bool
    @EnvironmentObject var rootViewModel: MainViewModel
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
                            
                            FavoriteButton(house: house, imageName: rootViewModel.contains(house) ? "heart.fill" : "heart", size: 20)
                                .onTapGesture {
                                    if (rootViewModel.contains(house)) {
                                        withAnimation(.spring) {
                                            Logger.localStorage.info("In \(HouseInfoView.self): Planning to delete \(house.name) from wishlist...")
                                            isDeleting = true
                                        }
                                    } else {
                                        withAnimation(.spring) {
                                            Logger.localStorage.info("In \(HouseInfoView.self): Adding \(house.name) to wishlist...")
                                            rootViewModel.toggleFavorite(house: house)
                                        }
                                    }
                                }
                            // show an alert after clicking the wishlist icon
                                .alert("Remove from wishlist?", isPresented: $isDeleting) {
                                    Button("Remove", role: .destructive) {
                                        withAnimation(.spring) {
                                            Logger.localStorage.info("In \(HouseInfoView.self): Starting to delete \(house.name) from wishlist...")
                                            rootViewModel.toggleFavorite(house: house)
                                            isDeleting = false
                                        }
                                    }
                                    Button("Cancel", role: .cancel) {
                                        isDeleting = false
                                    }
                                } message: {
                                    Text("\"\(house.name)\" will be permanently deleted.")
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
