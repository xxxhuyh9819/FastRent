//
//  NoConnectionView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/3/2.
//

import SwiftUI

/// A view shown when there's no internet connection
struct NoConnectionView: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.appBackground)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .frame(height: 100)
                .overlay {
                    HStack(alignment: .top) {
                        Image(systemName: "wifi.slash")
                            .foregroundStyle(.pink)
                            .font(.system(size: 40))
                        Text("Oops, the Internet connection appears to be offline. Please check your Internet connection.")
                            .font(.subheadline)
                            .padding(.trailing)
                    }
                    .padding()
                }
                .shadow(color: .shadow, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    NoConnectionView()
}
