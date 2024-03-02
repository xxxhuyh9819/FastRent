//
//  SearchAndFilterBar.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/29.
//

import SwiftUI

/// A component to show the SearchView upon being tapped
struct SearchBar: View {
    @Binding var location: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            VStack(alignment: .leading, spacing: 2) {
                if (location.isEmpty) {
                    Text("Search")
                        .font(.footnote)
                        .fontWeight(.semibold)
                } else {
                    Text(location)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                    
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .overlay {
            Capsule()
                .stroke(lineWidth: 0.5)
                .foregroundStyle(.gray)
                .shadow(color: .black.opacity(0.4), radius: 2)
        }
        .padding()
    }
}

#Preview {
    SearchBar(location: .constant("Chicago"))
}

