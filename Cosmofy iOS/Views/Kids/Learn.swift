//
//  Learn.swift
//  Cosmofy iOS
//
//  Created by Arryan Bhatnagar on 8/3/24.
//

import SwiftUI

struct Learn: View {
    @ObservedObject var viewModel: ViewModelAPOD

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    VStack {
                        HStack {
                            Text("Planets")
                                .font(.title2)
                                .fontWeight(.medium)
                                .fontDesign(.rounded)
                            Spacer()
                        }
                        .padding(.horizontal)
                        HStack {
                            Text("Learn about the bodies in our solar system")
                                .font(.title3)
                                .fontWeight(.regular)
                                .fontDesign(.rounded)
                                .foregroundStyle(.secondary)
                            Spacer()
                        }
                        .padding(.horizontal)
                        ScrollView(.horizontal) {
                            planets
                        }
                        .safeAreaPadding(.horizontal, 16)
                        .safeAreaPadding(.bottom, 16)
                        .scrollTargetBehavior(.paging)
                        .scrollIndicators(.hidden)
                    }
                    .padding(.top)
                    
                    Divider()
                    
                    VStack {
                        HStack {
                            Text("More in Space")
                                .font(.title2)
                                .fontWeight(.medium)
                                .fontDesign(.rounded)
                            Spacer()
                        }
                        .padding(.horizontal)
                        HStack {
                            Text("Read Interesting Articles")
                                .font(.title3)
                                .fontWeight(.regular)
                                .fontDesign(.rounded)
                                .foregroundStyle(.secondary)
                            Spacer()
                        }
                        .padding(.horizontal)
                        ScrollView(.horizontal) {
                            facts
                        }
                        .safeAreaPadding(.horizontal, 16)
                        .safeAreaPadding(.bottom, 16)
                        .scrollTargetBehavior(.paging)
                        .scrollIndicators(.hidden)
                    }
                    .padding(.top)
                    Divider()
                    VStack {
                        HStack {
                            Text("Astronomy Picture of the Day")
                                .font(.title2)
                                .fontWeight(.medium)
                                .fontDesign(.rounded)
                            Spacer()
                        }
                        .padding(.horizontal)
                        HStack {
                            Text("View a new image everyday")
                                .font(.title3)
                                .fontWeight(.regular)
                                .fontDesign(.rounded)
                                .foregroundStyle(.secondary)
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top)
                    
                    IOTDViewKids(viewModel: viewModel)

                }
            }
            .navigationTitle("Learn")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
    #if !os(tvOS)
                UINavigationBar.appearance().largeTitleTextAttributes = [
                    .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont.systemFont(ofSize: 34, weight: .semibold),
                ]
    #endif
            }
            
        }
        
    }
    
    private var planets: some View {
        LazyHStack(spacing: 8) {
            ForEach(allPlanets) { planet in
                NavigationLink(destination: KidsPlanetView(planet: planet)) {
                    Rectangle().fill(planet.color.gradient)
                        .frame(height: 170)
                        .containerRelativeFrame(.horizontal)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay {
                            VStack {
                                HStack {
                                    Text(planet.name)
                                        .font(.title2)
                                        .fontDesign(.rounded)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                    Spacer()
                                    Image(planet.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 65, height: 65)
                                }
                                Spacer()
                                HStack {
                                    Text(planet.description)
                                        .font(.subheadline)
                                        .foregroundStyle(.white)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                            }
                            .padding()
                        }
                }
            }
        }
    }
    
    private var facts: some View {
        LazyHStack(spacing: 8) {
            ForEach(allFacts) { fact in
                NavigationLink(destination: fact.navigaton) {
                    
                    Rectangle().fill(fact.color.gradient)
                        .frame(height: 170)
                        .containerRelativeFrame(.horizontal)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay {
                            VStack {
                                HStack {
                                    Text(fact.title)
                                        .font(.title2)
                                        .fontDesign(.rounded)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                    Spacer()
                                    Image(fact.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 65, height: 65)
                                }
                                Spacer()
                                HStack {
                                    Text(fact.subtitle)
                                        .font(.subheadline)
                                        .foregroundStyle(.white)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                            }
                            .padding()
                        }
                }
            }
        }
    }
    
    
}

let allFacts: [Fact] = [

    Fact(color: Color.orange, title: "The Sun", subtitle: "Think Earth is the most important spot in the solar system? Think again. The sun is the real star of the show—literally!", imageName: "sun", navigaton: AnyView(SunArticle())),
    Fact(color: Color.teal, title: "Asteroids", subtitle: "Asteroids are the rubble left over from the solar system’s formation roughly 4.6 billion years ago.", imageName: "asteroid", navigaton: AnyView(AsteroidsArticle())),
//    Fact(color: Color.black.opacity(0.9), title: "Titan", subtitle: "Saturn's largest moon!", imageName: "moon", navigaton: IOTDView()),
    Fact(color: Color.red, title: "The Moon Landing", subtitle: "Think Earth is the most important spot in the solar system? Think again. The sun is the real star of the show—literally!", imageName: "landing", navigaton: AnyView(TheMoonLandingArticle()))
    
]

struct Fact: Identifiable {
    var id = UUID()
    var color: Color
    var title: String
    var subtitle: String
    var imageName: String
    var navigaton: AnyView
}




struct IOTDViewKids: View {
    @ObservedObject var viewModel = ViewModelAPOD()

    var body: some View {
        VStack {
            ScrollView {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .padding()
                        .foregroundStyle(.red)
                } else if let apod = viewModel.apod {
                    VStack {
                        VStack(spacing: 8) {
                            
                            VStack {
                                HStack {
                                    Text(apod.title)
                                        .font(Font.system(size: 42))
                                        .bold()
                                        .fontWidth(.compressed)
                                    Spacer()
                                }
                                HStack {
                                    Text(convertDateString(dateString: apod.date))
                                        .italic()
                                        .font(.body)
                                        .fontDesign(.serif)
                                    Spacer()
                                }
                            }
                        }
                        .padding()
                        if apod.media_type == "video" {
                            WebView(urlString: apod.url)
                                .frame(height: 300)
                                .padding(.horizontal)
                        } else {
                            if apod.hdurl != nil {
                                ImageView(apod.hdurl!)
                                    .padding(.horizontal)
                            } else {
                                ImageView(apod.url)
                                    .padding(.horizontal)
                            }
                        }

                    }
                } else {
                    ProgressView("Loading...")
                        .padding()
                }
            }
        }
    }
}
