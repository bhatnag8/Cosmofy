//
//  Learn.swift
//  Cosmofy iOS
//
//  Created by Arryan Bhatnagar on 8/3/24.
//

import SwiftUI

struct Learn: View {
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
                        
                    }
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
                Rectangle().fill(planet.color.gradient)
                    .frame(height: 180)
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
    
    private var facts: some View {
        LazyHStack(spacing: 8) {
            ForEach(allFacts) { fact in
                Rectangle().fill(fact.color.gradient)
                    .frame(height: 180)
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

let allFacts: [Fact] = [

    Fact(color: Color.orange, title: "The Sun", subtitle: "Think Earth is the most important spot in the solar system? Think again. The sun is the real star of the show—literally!", imageName: "sun", navigaton: IOTDView()),
    Fact(color: Color.teal, title: "Asteroids", subtitle: "Asteroids are the rubble left over from the solar system’s formation roughly 4.6 billion years ago.", imageName: "asteroid", navigaton: IOTDView()),
    Fact(color: Color.green, title: "Titan", subtitle: "Saturn's largest moon!", imageName: "moon", navigaton: IOTDView()),
    Fact(color: Color.red, title: "The Moon Landing", subtitle: "Think Earth is the most important spot in the solar system? Think again. The sun is the real star of the show—literally!", imageName: "landing", navigaton: IOTDView())
    
]

struct Fact: Identifiable {
    var id = UUID()
    var color: Color
    var title: String
    var subtitle: String
    var imageName: String
    var navigaton: any View
}



#Preview {
    TabBarKids()
}
