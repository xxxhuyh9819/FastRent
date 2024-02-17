//
//  ApartmentPopOverView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/16.
//

import SwiftUI

struct ApartmentPopOverView: View {
    
    let apartment: Apartment
    @Environment(\.dismiss) var dismiss
    @State private var showDetail: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(apartment.title)
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
                        Text(apartment.address)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text("$\(apartment.price) / month")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        DetailView(apartment: apartment)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .navigationBarBackButtonHidden()
                    } label: {
                        RoundButton(imageName: "chevron.right")
                            .onTapGesture {
                                showDetail.toggle()
                            }
                    }
                    // src https://www.hackingwithswift.com/quick-start/swiftui/how-to-present-a-full-screen-modal-view-using-fullscreencover
                    .fullScreenCover(isPresented: $showDetail, content: {
                        DetailView.init(apartment: apartment)
                    })
                }
                GeometryReader { geometry in
                    ImageCarousel(apartment: apartment)
                        .frame(width: geometry.size.width)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ApartmentPopOverView(apartment: dummyApartments[0])
}
