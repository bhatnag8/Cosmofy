//
//  SplashScreenView.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/9/24.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: 0xD2DFF7), // Top-left
                    Color(hex: 0xE1E8F4), // Top-right
                    Color(hex: 0xC8D5F1), // Bottom-right
                    Color(hex: 0xB7C5F4)  // Bottom-left
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            Image("app-icon-4k")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 64, height: 64)
                .edgesIgnoringSafeArea(.all)

            
            VStack {
                Spacer()
                Text("- 1.1.1 -")
                    .font(Font.custom("SF Pro Rounded Regular", size: 17))
                    .foregroundColor(.black)
            }
            .padding()
        }
    }
}



#Preview {
    SplashScreenView()
}

