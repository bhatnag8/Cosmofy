//
//  Home.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/9/24.
//  173

import SwiftUI
import MapKit

struct Home: View {
    
    @ObservedObject var viewModel: ViewModelAPOD
    @State private var trigger: Bool = false
    @AppStorage("firstName") var currentFirstName: String?

    @Binding var complete: Bool
    @Binding var failed: Bool
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                Text("Begin your space journey")
                    .foregroundStyle(.secondary)
                    .fontDesign(.rounded)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.horizontal)

                Text("Hello \(currentFirstName ?? "individual").")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .font(.largeTitle)
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.blue,
                                Color.purple,
                                Color.pink,
                                Color.orange,
                                Color.yellow
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .padding(.top, 32)
                    .padding(.horizontal)
                    

                Text("What would you like to do today?")
                    .foregroundStyle(.secondary)
                    .fontDesign(.rounded)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 32)

                NavView(
                    view: IOTDView(viewModel: viewModel),
                    imageName: "home-icon-2",
                    title: "Picture of the Day",
                    subtitle: "View a new astronomy image every day"
                )
                
                NavView(
                    view: ArticleView(),
                    imageName: "home-icon-1",
                    title: "Article of the Month",
                    subtitle: "Read a new space article every month"
                )
                
                NavView(
                    view: RNNMaybach(complete: $complete, failed: $failed),
                    imageName: "home-icon-4",
                    title: "Nature Scope",
                    subtitle: "View natural events and disasters around the globe"
                )
                



            }
            .onAppear {
                UINavigationBar.appearance().largeTitleTextAttributes = [
                    .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont(descriptor: UIFont.systemFont(ofSize: 34, weight: .semibold).fontDescriptor.withDesign(.rounded)!, size: 34),
                ]
            }
            .navigationTitle("Cosmofy")
        }
        
    }
    
    
    
}

struct ArticleView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    NavigationLink(destination: NovemberView()) {
                        VStack(spacing: 0) {
                            
                            Image("November Article")
                                .resizable()
                                .frame(height: 180)
                                .scaledToFit()
                            HStack {
                                VStack {
                                    Text("11")
                                        .font(.largeTitle)
                                        .fontDesign(.serif)
                                    
                                    Text("2024")
                                        .fontDesign(.serif)
                                        .foregroundStyle(.secondary)
                                }
                                
                                
                                VStack(spacing: 4) {
                                    HStack {
                                        Text("It Might Be Possible to Detect Gravitons After All")
                                            .multilineTextAlignment(.leading)
                                            .font(Font.custom("SF Pro Rounded Regular", size: 16))
                                            .foregroundColor(.primary)
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Text("Charlie Wood")
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
                    NavigationLink(destination: OctoberView()) {
                        VStack(spacing: 0) {
                            
                            Image("October Article")
                                .resizable()
                                .frame(height: 180)
                                .scaledToFit()
                            HStack {
                                VStack {
                                    Text("10")
                                        .font(.largeTitle)
                                        .fontDesign(.serif)
                                    
                                    Text("2024")
                                        .fontDesign(.serif)
                                        .foregroundStyle(.secondary)
                                }
                                
                                
                                VStack(spacing: 4) {
                                    HStack {
                                        Text("The #1 Clue to Quantum Gravity Sits on the Surfaces of Black Holes")
                                            .multilineTextAlignment(.leading)
                                            .font(Font.custom("SF Pro Rounded Regular", size: 16))
                                            .foregroundColor(.primary)
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Text("Joseph Howlett")
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
                    
                    NavigationLink(destination: SeptemberView()) {
                        VStack(spacing: 0) {
                            
                            Image("September Article")
                                .resizable()
                                .frame(height: 180)
                                .scaledToFit()
                            HStack {
                                VStack {
                                    Text("09")
                                        .font(.largeTitle)
                                        .fontDesign(.serif)
                                    
                                    Text("2024")
                                        .fontDesign(.serif)
                                        .foregroundStyle(.secondary)
                                }
                                
                                
                                VStack() {
                                    HStack {
                                        Text("The Webb Telescope Further Deepens the Biggest Controversy in Cosmology")
                                            .multilineTextAlignment(.leading)
                                            .font(Font.custom("SF Pro Rounded Regular", size: 16))
                                            .foregroundColor(.primary)
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Text("Liz Kruesi")
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
                    
                    NavigationLink(destination: AugustView()) {
                        VStack(spacing: 0) {
                            
                            Image("August Article")
                                .resizable()
                                .frame(height: 180)
                                .scaledToFit()
                            HStack {
                                VStack {
                                    Text("08")
                                        .font(.largeTitle)
                                        .fontDesign(.serif)
                                    
                                    Text("2024")
                                        .fontDesign(.serif)
                                        .foregroundStyle(.secondary)
                                }
                                
                                
                                VStack() {
                                    HStack {
                                        Text("The Best Neighborhoods for Starting a Life in the Galaxy")
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

struct SeptemberView: View {
    var body: some View {
        WebView(urlString: "https://www.quantamagazine.org/the-webb-telescope-further-deepens-the-biggest-controversy-in-cosmology-20240813/")
            .navigationTitle("Article of the Month")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: ShareLink(item: URL(string: "https://www.quantamagazine.org/the-webb-telescope-further-deepens-the-biggest-controversy-in-cosmology-20240813/")!, preview: SharePreview("Cosmofy's Article of the Month", image: Image("iconApp")))
            )
    }
}

struct OctoberView: View {
    var body: some View {
        WebView(urlString: "https://www.quantamagazine.org/the-1-clue-to-quantum-gravity-sits-on-the-surfaces-of-black-holes-20240925/")
            .navigationTitle("Article of the Month")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: ShareLink(item: URL(string: "https://www.quantamagazine.org/the-1-clue-to-quantum-gravity-sits-on-the-surfaces-of-black-holes-20240925/")!, preview: SharePreview("Cosmofy's Article of the Month", image: Image("iconApp")))
            )
    }
}

struct NovemberView: View {
    var body: some View {
        WebView(urlString: "https://www.quantamagazine.org/it-might-be-possible-to-detect-gravitons-after-all-20241030/")
            .navigationTitle("Article of the Month")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: ShareLink(item: URL(string: "https://www.quantamagazine.org/it-might-be-possible-to-detect-gravitons-after-all-20241030/")!, preview: SharePreview("Cosmofy's Article of the Month", image: Image("iconApp")))
            )
    }
}

struct NavView<Destination: View>: View {
    
    var view: Destination
    var imageName: String
    var title: String
    var subtitle: String
    
    var body: some View {
        NavigationLink(destination: view) {
            HStack(spacing: 16) {
                
                Image(imageName)
                    .resizable()
                    .frame(width: 32, height: 32)
                
                VStack {
                    HStack {
                        Text(title)
                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                        if title == "Astronauts" {
                            Text("NEW")
                                .font(.caption2)
                                .foregroundStyle(.orange)
                                .padding(4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4.0)
                                        .stroke(lineWidth: 1.0)
                                        .foregroundStyle(.orange)
                                )
                        } else {
                            Text("")
                                .font(.caption2)
                                .foregroundStyle(.clear)
                                .padding(4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4.0)
                                        .stroke(lineWidth: 1.0)
                                        .foregroundStyle(.clear)
                                )
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Text(subtitle)
                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    
                }
                Image(systemName: "chevron.right")
            }
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 24))
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
    
}


extension Text {
    public func foregroundLinearGradient(
        colors: [Color],
        startPoint: UnitPoint,
        endPoint: UnitPoint) -> some View
    {
        self.overlay {

            LinearGradient(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint
            )
            .mask(
                self

            )
        }
    }
}
