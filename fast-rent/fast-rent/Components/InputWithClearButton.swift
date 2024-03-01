//
//  InputWithClearButton.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/29.
//

import SwiftUI

struct InputWithClearButton: View {
    
    @Binding var text: String
    let titleKey: String
    
    var body: some View {
        HStack {
            TextField(titleKey, text: $text)
                .onSubmit {
                    print("submitted! \(text)")
                }
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

#Preview {
    InputWithClearButton(text: .constant("dasd"), titleKey: "Enter place")
}

