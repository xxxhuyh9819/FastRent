//
//  ListView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct ExploreView: View {
    
    let apartments: [Apartment] = dummyApartments
    @State var showMap: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(apartments, id: \.id) {apartment in
                    NavigationLink{
                        DetailView(apartment: apartment)
                            .navigationBarBackButtonHidden()
                    } label: {
                        ListItemView(apartment: apartment)
                            .tint(.black)
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
                MapView(apartments: apartments)
            }
        }
    }
}

#Preview {
    ExploreView()
}
