//
//  Tester.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 4/26/24.
//

import SwiftUI

struct Tester: View {
    @State private var scale: CGFloat = 1.0
    @State private var isAnimating = false

    var body: some View {
        VStack {
            Spacer()
            
            RoundedRectangle(cornerRadius: 35)
                .frame(width: isAnimating ? UIScreen.main.bounds.width : 200, height: isAnimating ? UIScreen.main.bounds.height : 200)
                .foregroundColor(.blue)
                .scaleEffect(scale)
                .animation(.interpolatingSpring(stiffness: 50, damping: 8), value: scale)
                .animation(.easeInOut(duration: 0.2), value: isAnimating)
                .onTapGesture {
                    withAnimation(.spring(response: 0.2, dampingFraction: 0.6, blendDuration: 0)) {
                        scale = 0.7
                    }
                    // Delay for compression effect
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        withAnimation(.interpolatingSpring(stiffness: 50, damping: 10)) {
                            scale = 1.35 // Slight overshoot for bubbly effect
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                scale = 1
                                isAnimating = true
                            }
                        }
                    }
                }
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)  // To allow expansion to fill the screen
    }
}

#Preview {
    Tester()
}
