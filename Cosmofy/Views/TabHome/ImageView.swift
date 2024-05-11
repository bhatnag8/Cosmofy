//
//  IOTD.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/15/24.
//

import SwiftUI
import WebKit

struct IOTDView: View {
    
    @ObservedObject var viewModel = ViewModelAPOD()
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .padding()
                        .foregroundStyle(.red)
                } else if let apod = viewModel.apod {
                    VStack {
                        HStack {
                            Text(apod.title)
                                .padding(.vertical, 8)
                                .font(Font.custom("SF Pro Rounded Medium", size: 24))
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                        
                        // Check the media type
                        if apod.media_type == "video" {
                            WebView(urlString: apod.url)
                                .frame(height: 300) // Set a fixed height for the video player
                                .padding(.horizontal)
                        } else {
                            ImageView(apod.url)
                                .padding(.horizontal)
                        }
                        
                        WordByWordTextView("Each day a different image or photograph of our fascinating universe is featured, along with a brief explanation written by a professional astronomer. The information is provided by NASA.", interval: 0.015)
                            .foregroundStyle(.secondary)
                            .font(Font.custom("SF Pro Rounded Regular", size: 14))
                            .padding()
                        
                        if !apod.explanation.isEmpty {
                            WordByWordTextView(apod.explanation, interval: 0.015)
                                .padding(.horizontal)
                                .font(Font.custom("SF Pro Rounded Regular", size: 16))
                        }
                        
                    }
                } else {
                    LoadingView(color: .labelColorMod)
                        .frame(width: 50, height: 25)
                        .padding()
                }
            }
            .navigationTitle("Today's Picture")
            .onAppear(perform: viewModel.fetch)
            .onAppear(perform: {Haptics.shared.vibrate(for: .success)})
            
        }
        .navigationTitle("Today's Picture")
        
    }
    
    
}

struct ImageView: View {
    
    @ObservedObject var imageLoader = ImageLoader()
    
    init(_ url: String) {
        self.imageLoader.load(url)
    }
    
    var body: some View {
        if let image = imageLoader.downloadedImage {
            return Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit) // Or use .fill as per your need
        } else {
            return Image("").resizable()
                .aspectRatio(contentMode: .fit) // Or use .fill as per your need
        }
    }
}



struct WebView: UIViewRepresentable {
    
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: urlString) else {
            return WKWebView()
        }
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Leave this empty for now
    }
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
                    DispatchQueue.main.async {
                        self.animateText()
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
