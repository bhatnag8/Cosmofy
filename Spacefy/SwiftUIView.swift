//
//  SwiftUIView.swift
//  Spacefy
//
//  Created by Arryan Bhatnagar on 3/7/23.
//

import SwiftUI

struct SwiftUIView: View {
    
    private let colors: [Color] = [.gray, .blue, .green, .orange, .brown]
    
    var body: some View {
        VStack {
            TabView {
                ForEach(colors, id: \.self) { color in
                    ZStack {
                        color
                        Text("\(color.description)")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
            .edgesIgnoringSafeArea(.all)
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
