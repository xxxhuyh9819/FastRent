//
//  ApartmentPopOverView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct ApartmentPopOverView: View {
    
    let house: ConvertedHouse
    @Environment(\.dismiss) var dismiss
    @State private var showDetail: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(house.title)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    RoundButton(imageName: "xmark")
                        .onTapGesture {
                            dismiss()
                        }
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(house.address)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text("$\(house.price) / month")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        DetailView(house: house)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .navigationBarBackButtonHidden()
                    } label: {
                        RoundButton(imageName: "chevron.right")
                            .onTapGesture {
                                showDetail.toggle()
                            }
                    }
                     //src https://www.hackingwithswift.com/quick-start/swiftui/how-to-present-a-full-screen-modal-view-using-fullscreencover
                    .fullScreenCover(isPresented: $showDetail, content: {
                        DetailView.init(house: house)
                    })
                }
                GeometryReader { geometry in
                    ImageCarousel(house: house)
                        .frame(width: geometry.size.width)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ApartmentPopOverView(house: ConvertedHouse(house: Preview.dummyApartment))
}
