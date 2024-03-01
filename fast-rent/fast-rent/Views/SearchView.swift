//
//  DestinationSearchView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/29.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var show: Bool
    @State var isLeaving = false
    @EnvironmentObject var viewModel: MainViewModel
        
    var body: some View {
        
        NavigationStack {
            VStack(alignment: .leading, spacing: 8) {
                
                Text("Where to live?")
                    .font(.title3)
                    .fontWeight(.bold)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Enter city", text: $viewModel.location)
                        .font(.footnote)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .overlay {
                    Capsule()
                        .stroke(lineWidth: 0.5)
                        .foregroundStyle(.gray)
                        .shadow(color: .black.opacity(0.4), radius: 2)
                }
            }
            .modifier(SearchSectionModifier())
            .padding()
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text("What's your budget?")
                    .font(.title3)
                    .fontWeight(.bold)
                
                HStack(spacing: 10) {
                    HStack {
                        TextField("No Min", text: $viewModel.minPrice)
                            .keyboardType(.numberPad)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .overlay {
                        Capsule()
                            .stroke(lineWidth: 0.5)
                            .foregroundStyle(.gray)
                            .shadow(color: .black.opacity(0.4), radius: 2)
                    }
                    
                    Rectangle()
                        .frame(width: 12, height: 1)
                        .foregroundStyle(.gray)
                    
                    HStack {
                        TextField("No Max", text: $viewModel.maxPrice)
                            .keyboardType(.numberPad)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .overlay {
                        Capsule()
                            .stroke(lineWidth: 0.5)
                            .foregroundStyle(.gray)
                            .shadow(color: .black.opacity(0.4), radius: 2)
                    }
                }
                .font(.footnote)
            }
            .modifier(SearchSectionModifier())
            .padding()
            

            
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation(.spring) {
                            isLeaving = true
                        }
                    } label: {
                        Image(systemName: "xmark.circle")
                            .foregroundStyle(.gray)
                    }
                    // show an alert after clicking the x button
                    .alert("Leave the searching page?", isPresented: $isLeaving) {
                        Button("Leave", role: .destructive) {
                            withAnimation(.spring) {
                                show.toggle()
                                viewModel.clear()
                                print("Left!")
                            }
                        }
                        Button("Cancel", role: .cancel) {
                            isLeaving = false
                        }
                    } message: {
                        Text("You have an unsaved destination. Leaving the page will erase it.")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // exit SearchView
                        withAnimation(.spring) {
                            viewModel.filterHouses()
                            print("Finished Searching!")
                            show.toggle()
                        }
                    } label: {
                        Text("Done")
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                    }
                    .disabled(viewModel.location.isEmpty)
                    .opacity(viewModel.location.isEmpty ? 0.5 : 1)
                }
            }
        }
        .padding(.top)
        
        Spacer()
    }
}


#Preview {
    SearchView(show: .constant(true))
}
