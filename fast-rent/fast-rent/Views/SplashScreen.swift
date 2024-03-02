//
//  SplashScreen.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/3/1.
//

import SwiftUI

/*
 A splash screen that disappears after 1 second or upon being tapped.
 */
struct SplashScreen: View {
    
    @State private var showSplashScreen = false
    
    var body: some View {
        if showSplashScreen {
            MainTabView()
        } else {
            VStack {
                Image(.splashScreen)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                Text("fast-rent")
                    .font(.title2)
                    .foregroundColor(.black.opacity(0.8))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                self.showSplashScreen.toggle()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if (!self.showSplashScreen) {
                        self.showSplashScreen.toggle()
                    }
                }
            }
        }
        
    }
}

#Preview {
    SplashScreen()
}
