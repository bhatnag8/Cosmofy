//
//  CosmofyApp.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/9/24.
//

import Foundation
import SwiftUI

@main
struct CosmofyApp: App {
    var body: some Scene {
        WindowGroup {
            SplashScreen()
        }
    }
}


struct SplashScreen: View {
    @State private var showSplash = true

    var body: some View {
        ZStack {
            if showSplash {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.05) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                TabBarView()
                    .onAppear {
                        #if !os(tvOS)
                        UINavigationBar.appearance().largeTitleTextAttributes = [
                            .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont.systemFont(ofSize: 34, weight: .semibold),
                        ]
                        #endif
                    }
            }
        }
    }
}

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
            
//            VStack {
//                Spacer()
//                Text("1.3")
//                    .font(.headline)
//                    .foregroundColor(.black)
//            }
//            .padding()
        }
    }
}
