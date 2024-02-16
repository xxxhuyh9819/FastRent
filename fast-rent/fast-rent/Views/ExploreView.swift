//
//  ListView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct ExploreView: View {
    
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(0...3, id: \.self) {rect in
                    NavigationLink{
                        DetailView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        ListItemView()
                            .tint(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    ExploreView()
}
