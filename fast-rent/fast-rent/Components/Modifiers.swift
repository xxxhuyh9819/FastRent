//
//  Modifiers.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/29.
//

import Foundation
import SwiftUI

// custom modifier
struct SearchSectionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: 360)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct InputModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textInputAutocapitalization(.never)
            .padding()
            .frame(width: 340, height: 40)
            .background(Color(.systemGray5))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
