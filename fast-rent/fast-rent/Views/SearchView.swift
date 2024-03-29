//
//  DestinationSearchView.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/2/29.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var showSearchView: Bool
    @State var isLeaving = false
    
    @EnvironmentObject var viewModel: MainViewModel
    
    @FocusState private var isEnteringLocation: Bool
    @FocusState private var isEnteringMinPrice: Bool
    @FocusState private var isEnteringMaxPrice: Bool
    
    var locationIsEmpty: Bool {
        return viewModel.location.isEmpty
    }
    
    var body: some View {
        
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Location")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    VStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            TextField("Enter city", text: $viewModel.location)
                                .font(.footnote)
                                .focused($isEnteringLocation)
                        }
                        .modifier(CapsuleModifier())
                        
                        if (locationIsEmpty) {
                            Text("Location is required!")
                                .font(.footnote)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .foregroundStyle(.red)
                        }
                    }
                }
                .modifier(SearchSectionModifier())
                .padding()
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Price")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 10) {
                        TextField("No Min", text: $viewModel.minPrice)
                            .focused($isEnteringMinPrice)
                            .keyboardType(.numberPad)
                            .modifier(CapsuleModifier())

                        
                        Rectangle()
                            .frame(width: 12, height: 1)
                            .foregroundStyle(.gray)
                        
                        TextField("No Max", text: $viewModel.maxPrice)
                            .keyboardType(.numberPad)
                            .modifier(CapsuleModifier())
                    }
                    .font(.footnote)
                }
                .modifier(SearchSectionModifier())
                .padding()
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Beds & Baths")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        CustomStepper(number: $viewModel.numBedrooms, title: "Bedrooms")
                            .modifier(CapsuleModifier())
                        
                        CustomStepper(number: $viewModel.numBathrooms, title: "Bathrooms")
                            .modifier(CapsuleModifier())
                    }
                    .font(.footnote)
                }
                .modifier(SearchSectionModifier())
                .padding()
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    
                    // Button to cancel the search and dismiss SearchView
                    // If there is input, then trigger the alert by setting isLeaving to true.
                    // If there no input, then there's no loss of quitting. Just exit the view.
                    Button {
                        if (viewModel.inputNotEmpty()) {
                            isLeaving = true
                        } else {
                            withAnimation(.spring) {
                                showSearchView.toggle()
                            }
                        }
                    } label: {
                        Text("Cancel")
                            .fontWeight(.semibold)
                    }
                    .alert("Leave the searching page?", isPresented: $isLeaving) {
                        Button("Leave", role: .destructive) {
                            withAnimation(.spring) {
                                showSearchView.toggle()
                                // clear the fields when quitting
                                viewModel.clear()
                            }
                        }
                        Button("Cancel", role: .cancel) {
                            isLeaving = false
                        }
                    } message: {
                        Text("You have unsaved input. Leaving the page will erase it.")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    
                    // Button to execure the search and dismiss SearchView
                    // Disable when location is not entered (location is required in search)
                    Button {
                        // exit SearchView
                        withAnimation(.spring) {
                            viewModel.didFilter = true
                            showSearchView.toggle()
                        }
                    } label: {
                        Text("Done")
                            .fontWeight(.semibold)
                    }
                    .disabled(viewModel.location.isEmpty)
                    .opacity(viewModel.location.isEmpty ? 0.7 : 1)
                }
            }
        }
        .padding(.top)
        
        Spacer()
    }
}


#Preview {
    SearchView(showSearchView: .constant(true))
}
