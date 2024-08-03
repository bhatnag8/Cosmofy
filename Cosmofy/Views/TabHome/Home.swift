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
    @ObservedObject var astroService: AstroService

    @AppStorage("selectedProfile") var currentSelectedProfile: Int?
    
    var body: some View {
        
        NavigationStack {
            ScrollView(.vertical) {
                
                Button(action: {
                    withAnimation {
                        currentSelectedProfile = (currentSelectedProfile! % 3) + 1

                    }
                }) {
                    Text("Toggle Tab Bar")
                }
                
                articleOfTheMonth
                    .padding([.top, .horizontal])


                if let errorMessage = viewModel.errorMessage {
                    HStack {
                        Image(systemName: "exclamationmark.icloud")
                            .foregroundStyle(.white)
                            .font(.title2)
                            .padding()
                        
                        if errorMessage == "Failed to fetch data: The Internet connection appears to be offline.." {
                            Text("Sorry, you are not connected to the Internet 😩")
                                .fontWeight(.medium)
                                .fontDesign(.rounded)
                                .foregroundStyle(.white)
                                .padding(.vertical)
                                .padding(.trailing)
                        } else {
                            Text(errorMessage)
                                .fontWeight(.medium)
                                .fontDesign(.rounded)
                                .foregroundStyle(.white)
                                .padding(.vertical)
                                .padding(.trailing)
                        }
                        Spacer()
                    }
                    .background(Color.red.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)
                    
                } else if let apod = viewModel.apod {
                    
                    VStack(spacing: 0) {
                        VStack {
                            HStack {
                                Text("Astronomy Picture of the Day")
                                    .textCase(.uppercase)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            .padding([.top, .horizontal])
                            .padding(.bottom, 8)
                            
                            HStack {
                                Text(apod.title)
                                    .font(.largeTitle)
                                    .bold()
                                    .fontWidth(.compressed)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .padding(.horizontal)
                            
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
                        }
                                            
                        NavigationLink(destination: IOTDView(viewModel: viewModel)) {
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
                                    .padding(.trailing, 32)
                                    
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
                    .padding(.vertical)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .shadow(color: .black.opacity(0.2), radius: 4)
                        .frame(height: 500)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.top)
                        .padding(.horizontal)
                }
                
                AstronautsView(astroService: astroService)
                    .padding(.horizontal)
                    .padding(.bottom)
 
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
        
    }
    
    // MARK: articleOfTheMonth
    private var articleOfTheMonth: some View {
        ZStack {
            Image("August Article")
                .resizable()
                .scaledToFill()
                .variableBlur(radius: 6) { geometryProxy, context in
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
            
            VStack {
                HStack {
                    Text("Article of the month")
                        .textCase(.uppercase)
                        .foregroundStyle(Color.white)
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
                
                Spacer()
                
                NavigationLink(destination: AugustView()) {
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
        }
        .clipShape(RoundedRectangle.init(cornerRadius: 18))
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

struct NewUpdateView: View {
    var body: some View {
        ZStack() {
            Image("August")
                .resizable()
                .frame(height: 250)
                .aspectRatio(contentMode: .fit)
                .variableBlur(radius: 6) { geometryProxy, context in
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
//                .onAppear() {
//                    print("currentSelectedProfile: \(currentSelectedProfile)")
//                }

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
//                .shadow(color: .black, radius: 3)
        .shadow(color: .black.opacity(0.2), radius: 4)

        .padding([.horizontal, .top])
    }
}
