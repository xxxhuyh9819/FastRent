//
//  CarouselView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct CarouselView: View {
    var photos = ["regents-park", "solstice"]
    var body: some View {
        // a carousel of photos
        TabView {
            ForEach(photos, id: \.self) { photo in
                Image(photo)
                    .resizable()
                    .scaledToFill()
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    CarouselView()
}
