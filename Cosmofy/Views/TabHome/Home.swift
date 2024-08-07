//
//  Home.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/9/24.
//  173

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
                            Text("Cosmofy")
                                .font(Font.custom("SF Pro Rounded Semibold", size: 32))
                            Spacer()
                            GarenText(text: "1.2", trigger: trigger)
                                .font(Font.system(size: 18, weight: .semibold, design: .monospaced))
                            
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
                            }
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
                            }
                        }
                        

                    }
                    .padding(.horizontal)
                    .padding(.top, -12)
                }
                .padding([.leading, .trailing, .bottom])
            }
            .navigationTitle("")
            .padding(.top)
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
                
            }
        }
    }
    
    
}

struct ArticleView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    NavigationLink(destination: JulyView()) {
                        VStack(spacing: 0) {
                            
                            Image("July Article")
                                .resizable()
                                .frame(height: 180)
                                .scaledToFit()
                            HStack {
                                VStack {
                                    Text("07")
                                        .font(.largeTitle)
                                        .fontDesign(.serif)
                                    
                                    Text("2024")
                                        .fontDesign(.serif)
                                        .foregroundStyle(.secondary)
                                }
                                
                                
                                VStack() {
                                    HStack {
                                        Text("Astronomers Reimagine the Making of the Planets")
                                            .multilineTextAlignment(.leading)
                                            .font(Font.custom("SF Pro Rounded Regular", size: 16))
                                            .foregroundColor(.primary)
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Text("Rebecca Boyle")
                                            .multilineTextAlignment(.leading)
                                            .font(.caption)
                                            .italic()
                                                .fontDesign(.serif)
                                                .foregroundColor(.secondary)
                                        Spacer()
                                    }
                                }
                                .padding(.leading)
                                
                                Spacer()
                                
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                        }
                        .clipShape(RoundedRectangle.init(cornerRadius: 18))
                        
                    }
                    
                    
                    
                    NavigationLink(destination: JuneView()) {
                        VStack(spacing: 0) {
                            
                            Image("June Article")
                                .resizable()
                                .frame(height: 180)
                                .aspectRatio(contentMode: .fit)
                            
                            HStack {
                                VStack {
                                    Text("06")
                                        .font(.largeTitle)
                                        .fontDesign(.serif)
                                    
                                    Text("2024")
                                        .fontDesign(.serif)
                                        .foregroundStyle(.secondary)
                                }
                                
                                
                                VStack() {
                                    HStack {
                                        Text("What Is the Geometry of the Universe?")
                                            .multilineTextAlignment(.leading)
                                            .font(Font.custom("SF Pro Rounded Regular", size: 16))
                                            .foregroundColor(.primary)
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Text("Erica Klarreich & Lucy Reading-Ikkanda")
                                            .multilineTextAlignment(.leading)
                                            .font(.caption)
                                            .italic()
                                                .fontDesign(.serif)
                                                .foregroundColor(.secondary)
                                        Spacer()
                                    }
                                }
                                .padding(.leading)
                                
                                Spacer()
                                
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                        }
                        .clipShape(RoundedRectangle.init(cornerRadius: 18))
                        
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Articles")
        
    }
}

#Preview {
    
    Home()
    
}

struct JuneView: View {
    var body: some View {
        WebView(urlString: "https://www.quantamagazine.org/what-is-the-geometry-of-the-universe-20200316/")
            .navigationTitle("Article of the Month")
            .navigationBarTitleDisplayMode(.inline)
            
            .navigationBarItems(
                trailing: ShareLink(item: URL(string: "https://www.quantamagazine.org/what-is-the-geometry-of-the-universe-20200316/")!, preview: SharePreview("Cosmofy's Article of the Month", image: Image("iconApp")))
            )
    }
}


struct JulyView: View {
    var body: some View {
        WebView(urlString: "https://www.quantamagazine.org/how-are-planets-made-new-theories-are-taking-shape-20220609/")
            .navigationTitle("Article of the Month")
            .navigationBarTitleDisplayMode(.inline)
            
            .navigationBarItems(
                trailing: ShareLink(item: URL(string: "https://www.quantamagazine.org/how-are-planets-made-new-theories-are-taking-shape-20220609/")!, preview: SharePreview("Cosmofy's Article of the Month", image: Image("iconApp")))
            )
    }
}



