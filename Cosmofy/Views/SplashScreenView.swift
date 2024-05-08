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
                    Color(hex: 0xAF9AF9), // Top-left
                    Color(hex: 0xB3AEEC), // Top-right
                    Color(hex: 0xA4B2E8), // Bottom-right
                    Color(hex: 0xA7C5DA)  // Bottom-left
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            Image("appicon-without-gradient")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
            
            VStack {
                Spacer()
                Text("- 1.1 -")
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

