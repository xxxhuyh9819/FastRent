//
//  CustomStepper.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/3/1.
//

import SwiftUI

struct CustomStepper: View {
    
    @Binding var number: Int
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.semibold)
            
            Spacer()
            
            RoundButton(imageName: "minus")
                .onTapGesture {
                    number -= 1
                }
                .disabled(number == 0)
                .opacity(number == 0 ? 0.5 : 1)
            
            Text("\(number)")
                
            
            RoundButton(imageName: "plus")
                .onTapGesture {
                    number += 1
                }
        }
    }
}

#Preview {
    CustomStepper(number: .constant(1), title: "title")
}
