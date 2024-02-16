//
//  ListItemView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct ListItemView: View {
    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Regents Park")
                        .font(.subheadline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("1 bedroom - 1 bathroom")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                }
                
                Spacer()
                
                HStack {
                    Text("$1900")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("/ night")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ListItemView()
}