//
//  SplashScreen.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/9/24.
//

import Foundation
import SwiftUI

struct SplashScreen: View {
    @State private var showSplash = true

    var body: some View {
        ZStack {
            if showSplash {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                TabBarView()
            }
        }
    }
}

