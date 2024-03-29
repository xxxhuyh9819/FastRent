//
//  Modifiers.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/29.
//

import Foundation
import SwiftUI

/// For extracted custom modifiers that are reused in different views
/// Mainly for styling

struct SearchSectionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: 360)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .shadow, radius: 5)
    }
}

struct CapsuleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .padding(.vertical, 12)
            .overlay {
                Capsule()
                    .stroke(lineWidth: 0.5)
                    .foregroundStyle(.gray)
                    .shadow(color: .shadow.opacity(0.4), radius: 2)
            }
    }
}

struct SquareButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .font(.subheadline)
            .fontWeight(.semibold)
            .frame(width: 40, height: 40)
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
