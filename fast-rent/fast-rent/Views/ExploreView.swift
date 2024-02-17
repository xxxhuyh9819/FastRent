//
//  ListView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct ExploreView: View {
    
    let apartments: [Apartment] = [
        Apartment(id: NSUUID().uuidString, price: 1900),
        Apartment(id: NSUUID().uuidString, price: 2000),
        Apartment(id: NSUUID().uuidString, price: 1500),
    ]
    
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
        }
    }
}

#Preview {
    ExploreView()
}
