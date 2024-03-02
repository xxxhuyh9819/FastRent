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

struct CapsuleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .padding(.vertical, 12)
            .overlay {
                Capsule()
                    .stroke(lineWidth: 0.5)
                    .foregroundStyle(.gray)
                    .shadow(color: .black.opacity(0.4), radius: 2)
            }
    }
}

struct SwipeToDismissModifier: ViewModifier {
    var onDismiss: () -> Void
    @State private var offset: CGSize = .zero

    func body(content: Content) -> some View {
        content
            .offset(y: offset.height)
            .animation(.interactiveSpring(), value: offset)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.width < 50 {
                            offset = gesture.translation
                        }
                    }
                    .onEnded { _ in
                        if offset.height < -50 {
                            onDismiss()
                        } else {
                            offset = .zero
                        }
                    }
            )
    }
}
