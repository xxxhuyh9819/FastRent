//
//  EmptyWishlistView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/3/3.
//

import SwiftUI

struct EmptyWishlistView: View {
    var body: some View {
        VStack {
            Image(systemName: "heart.slash")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
            
            Text("No saved home yet")
                .font(.title2)
                .padding(.bottom)
            
            Text("Click the heart icon to save homes for quicker compare.")
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    EmptyWishlistView()
}
