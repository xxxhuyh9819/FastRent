//
//  ListView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct ExploreView: View {
    
    @State var showMap: Bool = false
    @StateObject var viewModel = ExploreViewModel()
    
    var convertedHouses: [ConvertedHouse] {
        var h = [ConvertedHouse]()
        
        for house in viewModel.houses {
            h.append(ConvertedHouse(house: house))
        }
        return h
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(viewModel.houses, id: \.id) {house in
                    NavigationLink {
                        DetailView(house: ConvertedHouse(house: house))
                            .navigationBarBackButtonHidden()
                    } label: {
                        ListItemView(house: ConvertedHouse(house: house))
                            .tint(Color("font-color"))
                    }
                    .overlay {
                        FavoriteButton(house: ConvertedHouse(house: house), imageName: fast_rentApp.db.contains(ConvertedHouse(house: house), viewModel.savedItems) ? "heart.fill" : "heart", size: 24)
                            .padding([.top, .trailing])
                            .onTapGesture {
                                fast_rentApp.db.toggleFav(convertedHouse: ConvertedHouse(house: house), savedHouses: &viewModel.savedItems)
                            }
                    }
                }
            }
//            .background(Color(uiColor: .systemGray4))
            .overlay(alignment: .bottom) {
                Button {
                    showMap.toggle()
                } label: {
                    HStack {
                        Text("Map")
                            .fontWeight(.semibold)
                        Image(systemName: "map.fill")
                    }
                    .frame(width: 84, height: 30)
                    .foregroundStyle(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .background(.gray)
                    .clipShape(Capsule())
                    .padding()
                }
                
            }
            .sheet(isPresented: $showMap) {
                MapView(houses: convertedHouses)
            }
        }
        // refresh the saved items upon entering and leaving the page
        .onAppear() {
            viewModel.savedItems = fast_rentApp.db.load()
        }
        .onDisappear {
            viewModel.savedItems = fast_rentApp.db.load()
        }
    }
}

#Preview {
    ExploreView()
}
