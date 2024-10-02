//
//  ContentView.swift
//  WatchCosmofy Watch App
//
//  Created by Arryan Bhatnagar on 6/15/24.
//

import SwiftUI
import Combine


struct CenterView: View {
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                /*
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
                 */
                LinearGradient(gradient: Gradient(colors: [
                               Color(red: 99/255, green: 211/255, blue: 185/255),  // Green
                               Color(red: 82/255, green: 139/255, blue: 211/255),  // Blue
                               Color(red: 102/255, green: 69/255, blue: 185/255)   // Purple
                           ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                           .ignoresSafeArea()
                
//                Image("home-banner-1")
//                    .resizable()
//                    .ignoresSafeArea(.all)
                
                ScrollView {
                    VStack {
                        Text("Cosmofy")
//                            .font(Font.custom("Bumbbled", size: 32))
//                            .foregroundStyle(.secondary)
                        
                        Text("2.0")
                            .font(.headline)
                            .fontDesign(.rounded)
//                                .textCase(.uppercase)
                            .foregroundStyle(.secondary)
                        Spacer()
                        HStack {
                            Text("< Picture of the Day")
//                                .font(Font.custom("Bumbbled", size: 16))
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Text("Planets >")
//                                .font(Font.custom("Bumbbled", size: 16))
                        }
                        
                    }
                    .padding()
                }
                .background(.ultraThinMaterial)
                
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    ShareLink(item: URL(string: "https://apps.apple.com/app/cosmofy/id6450969556")!, preview: SharePreview("Cosmofy on the Apple App Store", image: Image("iconApp")))
                }
            }
            
        }
        
        
    }
}


#Preview {
    CenterView()
}

struct WordByWordTextView: View {
    let fullText: String
    let animationInterval: TimeInterval
    @State private var displayedText: String = ""
    private let words: [String]
    
    init(_ text: String, interval: TimeInterval = 0.35) {
        self.fullText = text
        self.animationInterval = interval
        self.words = text.split { $0.isWhitespace }.map(String.init)
    }
    
    var body: some View {
        HStack {
            Text(displayedText)
                .onAppear {
                    if displayedText == "" {
                        DispatchQueue.main.async {
                            self.animateText()
                        }
                    }
                }
            Spacer()
        }
    }
    
    private func animateText() {
        var currentWordIndex = 0
        Timer.scheduledTimer(withTimeInterval: animationInterval, repeats: true) { timer in
            if currentWordIndex < words.count {
                let word = words[currentWordIndex]
                displayedText += (currentWordIndex == 0 ? "" : " ") + word
                currentWordIndex += 1
            } else {
                timer.invalidate()
            }
        }
    }
}
