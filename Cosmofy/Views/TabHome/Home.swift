//
//  Home.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/9/24.
//

import SwiftUI

struct Home: View {
    @State private var trigger: Bool = false

    var body: some View {
        
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 0) {
                    GeometryReader { proxy in
                        let size = proxy.size
                        ScrollView(.horizontal) {
                            HStack(spacing: 10) {
                                ForEach(imageList) { card in
                                    GeometryReader { geometry in
                                        let cardSize = geometry.size
                                        let minX = min(geometry.frame(in: .scrollView).minX * 1.2, geometry.size.width * 1.2)
                                        
                                        Image(card.imageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .offset(x: -minX)
                                            .frame(width: cardSize.width * 2)
                                            .frame(width: cardSize.width, height: cardSize.height)
                                            .overlay {
                                                OverlayView(card: card)
                                            }
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                            .shadow(color: card.color, radius: 3)
                                        
                                    }
                                    .frame(width: size.width - 50, height: size.height - 50)
                                    .scrollTransition(.interactive, axis: .horizontal) { view, phase in
                                        view.scaleEffect(phase.isIdentity ? 1 : 0.95)
                                    }
                                }
                            }
                            .padding(12)
                            .scrollTargetLayout()
                            .frame(height: size.height, alignment: .top)
                        }
                        .scrollTargetBehavior(.viewAligned)
                        .scrollIndicators(.hidden)
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.65)
                    .padding(.horizontal, -8)
                    
                    VStack() {
                        HStack {
                            GarenText(text: "Cosmofy", trigger: trigger, transition: .interpolate)
                                .font(Font.custom("SF Mono Semibold Italic", size: 32))

//                            Text("Cosmofy")
//                                .font(Font.custom("SF Pro Rounded Semibold", size: 32))
                            Spacer()
                            GarenText(text: "v1.1", trigger: trigger, transition: .interpolate)
                                .font(Font.custom("SF Mono Semibold Italic", size: 20))
                                .foregroundStyle(.blue)
                        }
                        
                        NavigationLink(destination: ArticleView()) {
                            HStack {
                                Image("home-icon-1")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text("Article of the Month")
                                    .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.black)
                            }
                        }
                        .onTapGesture {
                            Haptics.shared.vibrate(for: .success)
                        }
                        
                        NavigationLink(destination: IOTDView()) {
                            HStack {
                                Image("home-icon-2")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text("Picture of the Day")
                                    .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.black)
                            }
                        }
                        .onTapGesture {
                            Haptics.shared.vibrate(for: .success)
                        }
                        
//                        NavigationLink(destination: ChangelogView()) {
//                            HStack {
//                                Image("home-icon-3")
//                                    .resizable()
//                                    .frame(width: 30, height: 30)
//                                Text("v1.1 Change Log")
//                                    .font(Font.custom("SF Pro Rounded Medium", size: 18))
//                                    .foregroundColor(.primary)
//                                Spacer()
//                                Image(systemName: "chevron.right")
//                                    .foregroundStyle(.black)
//                            }
//                        }
                        .onTapGesture {
                            Haptics.shared.vibrate(for: .success)
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.top, -12)
                }
                .padding([.leading, .trailing, .bottom])
            }
        }
    }
    
    @ViewBuilder
    func OverlayView(card: ImageViewCard) -> some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(colors: [.clear, .clear, .clear, .black.opacity(0.1), .black.opacity(0.5), .black], startPoint: .top, endPoint: .bottom)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(card.title)
                        .font(Font.custom("SF Pro Rounded Semibold", size: 24))
                    
                    Text(card.subtitle)
                        .font(Font.custom("SF Pro Rounded Medium", size: 16))
                }
                .foregroundColor(.white)
                .padding()
                
                Spacer()
                
                Image(systemName: "arrow.right.circle.fill")
                    .padding(.horizontal, 24)
                    .font(.title)
                    .foregroundStyle(.white)
            }
        }
    }
    
    
}

struct ArticleView: View {
    var body: some View {
        WebView(urlString: "https://www.arryan.xyz/cosmofy/aotm")
            .navigationTitle("Article of the Month")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    Home()
}

struct ChangelogView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 12) {
                Text("Cosmofy Changelog")
                    .font(Font.custom("SF Pro Rounded Semibold", size: 28))
                    .foregroundColor(Color(.SOUR))
                    .padding(.top, 16)
                
                Text("Version 1.1 - June 2024")
                    .font(Font.custom("SF Pro Rounded Medium", size: 20))
                    .padding(.bottom, 24)


                section(title: "New Features 🌟") {
                    feature(title: "✨ Dark Mode", description: "Added a sleek dark mode for easier nighttime browsing.")
                    feature(title: "✨ Dark Mode", description: "Added a sleek dark mode for easier nighttime browsing.")
                    feature(title: "✨ Custom Stickers", description: "Introduced a set of cute custom stickers for messaging.")
                }
                
                section(title: "Improvements 🛠️") {
                    feature(title: "🔧 Performance Boost", description: "Optimized the app for faster loading times.")
                    feature(title: "🔧 Enhanced Security", description: "Improved security measures to protect user data.")
                }

                section(title: "Bug Fixes 🐛") {
                    feature(title: "🪲 Crash Fix", description: "Fixed an issue causing the app to crash on startup for some users.")
                    feature(title: "🪲 Notification Glitch", description: "Resolved a bug where notifications were not appearing properly.")
                }

                section(title: "Other Updates 🌼") {
                    feature(title: "📅 UI Tweaks", description: "Made some minor tweaks to the user interface for a more polished look.")
                    feature(title: "📅 Updated Terms", description: "Updated the terms of service to reflect new policies.")
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading) // Ensuring the sections take the full available width
        }
    }

    func section<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(Font.custom("SF Pro Rounded Medium", size: 20))
                .foregroundColor(Color(.SOUR))
                .padding(.bottom, 5)
            content()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black.opacity(0.025))
        .cornerRadius(16)
    }

    func feature(title: String, description: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(Font.custom("SF Pro Rounded Medium", size: 16))
                .foregroundColor(Color(.GUTS))
            Text(description)
                .font(Font.custom("SF Pro Rounded Medium", size: 14))
                .foregroundColor(Color.black)
        }
    }
}
