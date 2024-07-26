//
//  Home.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/9/24.
//  173

import SwiftUI
import Variablur

struct Home: View {
    @ObservedObject var viewModel: ViewModelAPOD
    @State var loaded: Bool = false
    
    var body: some View {
        
        NavigationStack {
            ScrollView(.vertical) {
                VStack {
                    
                    ZStack {
                        Image("August")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                        VStack {
                            Color.clear
                        }
                        .background(.regularMaterial)
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .environment(\.colorScheme, .dark)
                        
                        Image("August")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 250)
                            .mask(LinearGradient(
                                gradient: Gradient(
                                    stops: [
                                        .init(color: Color.black, location: 0.35),
                                        .init(color: Color.black.opacity(0), location: 0.75),
                                        .init(color: Color.black.opacity(0), location: 2)
                                    ]
                                ),
                                startPoint: .top,
                                endPoint: .bottom
                            ))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                        VStack(spacing: 5) {
                            
                            Spacer()
                            HStack {
                                Text("AUGUST 2024")
                                    .textCase(.uppercase)
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                            HStack {
                                Text("Introducing: Astronauts")
                                    .font(.title3)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                            HStack {
                                Text("Join the Adventure")
                                    .font(.subheadline)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.white.opacity(0.5))
                                Spacer()
                            }
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                }
                
                

                ZStack(alignment: .bottom) {
                    Image("August")
                        .resizable()
                        .frame(height: 250)
                        .aspectRatio(contentMode: .fit)
                        .variableBlur(radius: 6) { geometryProxy, context in
                            // draw a linear gradient across the entire mask from top to bottom
                            context.fill(
                                Path(geometryProxy.frame(in: .local)),
                                with: .linearGradient(
                                    .init(colors: [.white, .clear]),
                                    startPoint: .init(x: 0, y: geometryProxy.size.height),
                                    endPoint: .init(x: 0, y: geometryProxy.size.height*0.5)
                                )
                            )
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                    VStack(spacing: 5) {
                        
                        Spacer()
                        HStack {
                            Text("AUGUST 2024")
                                .textCase(.uppercase)
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        HStack {
                            Text("Introducing: Astronauts")
                                .font(.title3)
                                .fontDesign(.rounded)
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        HStack {
                            Text("Join the Adventure")
                                .font(.subheadline)
                                .fontDesign(.rounded)
                                .foregroundStyle(.white.opacity(0.5))
                            Spacer()
                        }
                    }
                    .padding()
                    
                    
                }
                .padding([.horizontal, .top])
                
                
                        
                
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .padding()
                        .foregroundStyle(.red)
                } else if let apod = viewModel.apod {
                    
                    NavigationLink(destination: IOTDView(viewModel: viewModel)) {
                        
                        VStack(spacing: 0) {
                            
                            VStack {
                                HStack {
                                    Text("Astronomy Picture of the Day")
                                        .textCase(.uppercase)
                                        .foregroundStyle(.secondary)
                                    Spacer()
                                }
                                .padding(.top)
                                .padding(.horizontal)
                                
                                Divider()
                                    .padding(.horizontal)
                                
                                HStack {
                                    Text(apod.title)
                                        .font(.largeTitle)
                                        .bold()
                                        .fontWidth(.compressed)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                .padding(.horizontal)
                                .padding(.top)
                                
                                HStack {
                                    Text(convertDateString(dateString: apod.date))
                                        .italic()
                                        .font(.body)
                                        .fontDesign(.serif)
                                    Spacer()
                                }
                                .padding(.horizontal)
                                .padding(.bottom)
                                
                            }
                            
                            .background(.ultraThinMaterial)
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 16,
                                    bottomLeadingRadius: 0,
                                    bottomTrailingRadius: 0,
                                    topTrailingRadius: 16
                                )
                            )
                            .padding(.horizontal)
                            
                            
                            if apod.media_type == "video" {
                                WebView(urlString: apod.url)
                                    .frame(height: 300)
                                    .padding(.horizontal)
                            } else {
                                ImageView(apod.url)
                                    .padding(.horizontal)
                                    .onAppear(perform: {
                                        loaded = true
                                    })
                                //                                    .scaledToFill()
                                
                            }
                            HStack {
                                VStack {
                                    HStack {
                                        Text("Read the description")
                                            .fontWeight(.medium)
                                            .fontDesign(.rounded)
                                            .foregroundColor(.primary)
                                        Spacer()
                                    }
                                    HStack {
                                        Text("and view older images")
                                            .fontDesign(.rounded)
                                            .foregroundColor(.secondary)
                                        Spacer()
                                    }
                                }
                                .padding()
                                
                                Image(systemName: "chevron.right")
                                    .padding(.horizontal)
                            }
                            .background(.ultraThinMaterial)
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 0,
                                    bottomLeadingRadius: 16,
                                    bottomTrailingRadius: 16,
                                    topTrailingRadius: 0
                                )
                            )
                            .padding(.horizontal)
                            
                        }

                    }
                    .padding(.top)
                    
                    
                }
                
                
                
                VStack {
                    
                    NavigationLink(destination: AugustView()) {
                        
                        ZStack {
                            
                            Image("August Article")
                                .resizable()
                                .scaledToFill()
                            
                            VStack {
                                Color.clear
                            }
                            .frame(maxWidth: .infinity)
                            .background(.ultraThickMaterial)
                            .environment(\.colorScheme, .dark)
                            
                            
                            
                            Image("August Article")
                                .resizable()
                                .scaledToFill()
                                .mask(LinearGradient(stops: [
                                    .init(color: .black.opacity(0), location: 0),
                                    .init(color: .black, location: 0.2),
                                    .init(color: .black.opacity(0.5), location: 0.7),
                                    .init(color: .black.opacity(0), location: 1),
                                ], startPoint: .top, endPoint: .bottom))
                            
                            VStack {
                                HStack {
                                    Text("Article of the month")
                                        .textCase(.uppercase)
                                        .foregroundStyle(Color.white)
                                    Spacer()
                                }
                                .padding(.top)
                                .padding(.horizontal)
                                
                                Divider()
                                    .tint(Color.white)
                                    .padding(.horizontal)
                                
                                Spacer()
                                
                                HStack {
                                    VStack {
                                        Text("08")
                                            .font(.title)
                                            .fontDesign(.serif)
                                            .foregroundStyle(.white)
                                        
                                        Text("2024")
                                            .fontDesign(.serif)
                                            .foregroundStyle(Color.white.opacity(0.6))
                                        
                                    }
                                    VStack {
                                        Text("The Best Neighborhoods for Starting a Life in the Galaxy")
                                            .multilineTextAlignment(.leading)
                                            .font(.subheadline)
                                            .fontDesign(.rounded)
                                            .fontWeight(.medium)
                                            .foregroundStyle(.white)
                                        HStack {
                                            Text("Rebecca Boyle")
                                                .font(.footnote)
                                                .multilineTextAlignment(.leading)
                                                .italic()
                                                .fontDesign(.serif)
                                                .foregroundStyle(Color.white.opacity(0.6))
                                            Spacer()
                                        }
                                        
                                    }
                                    .padding(.horizontal)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .padding()
                                        .foregroundStyle(.white)
                                    
                                }
                                .padding()
                            }
                            
                            
                        }
                        .clipShape(RoundedRectangle.init(cornerRadius: 18))
                        
                        
                    }
                }
                .padding()
                
                
            }
            .navigationTitle("Cosmofy")
            .onAppear {
#if !os(tvOS)
                UINavigationBar.appearance().largeTitleTextAttributes = [
                    .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont.systemFont(ofSize: 34, weight: .semibold),
                ]
#endif
            }
        }
        .onAppear() {
            if !loaded {
                viewModel.fetch()
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
    
    Home(viewModel: ViewModelAPOD())
    
    
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


struct AugustView: View {
    var body: some View {
        WebView(urlString: "https://www.quantamagazine.org/the-best-neighborhoods-for-starting-a-life-in-the-galaxy-20240124")
            .navigationTitle("Article of the Month")
            .navigationBarTitleDisplayMode(.inline)
        
            .navigationBarItems(
                trailing: ShareLink(item: URL(string: "https://www.quantamagazine.org/the-best-neighborhoods-for-starting-a-life-in-the-galaxy-20240124")!, preview: SharePreview("Cosmofy's Article of the Month", image: Image("iconApp")))
            )
    }
}

/*
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
 
 */

