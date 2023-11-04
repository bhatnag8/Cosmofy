//
//  GradientView.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 10/31/23.
//

import SwiftUI

struct GradientView: View {
    @State private var animateGradient: Bool = false
        
    private var startColor: Color = .appColorDarker
    private var endColor: Color = .GUTS
        
        
        var body: some View {
            VStack() {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.black)
            .padding(.horizontal)
            .multilineTextAlignment(.center)
            .background {
                LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                    .hueRotation(.degrees(animateGradient ? 45 : 0))
                    .onAppear {
                        withAnimation(.easeInOut(duration: 6).repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
                        }
                    }
            }
        }
        
}

#Preview {
    GradientView()
}
