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
    
    var body: some View {
        NavigationStack {
//            Button {
//                viewModel.clear()
//            } label: {
//                Text("dasd")
//            }
            ScrollView {
                ForEach(viewModel.houses, id: \.id) {house in
                    NavigationLink {
                        DetailView(house: house)
                            .navigationBarBackButtonHidden()
                    } label: {
                        ListItemView(house: house)
                            .tint(Color("font-color"))
                    }
                    .overlay {
//                        FavoriteButton(house: house)
                        Image(systemName: viewModel.contains(house) ? "heart.fill" : "heart")
                            .imageScale(.large)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity, maxHeight: .infinity/*@END_MENU_TOKEN@*/,  alignment: .topTrailing)
                            .foregroundStyle(.red)
                            .padding([.top, .trailing])
                            .onTapGesture {
                                viewModel.toggleFav(item: house)
                            }
                    }
                }
            }
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
                MapView(houses: viewModel.houses)
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
