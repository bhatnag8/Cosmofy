//
//  Planets.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/11/24.
//

import SwiftUI

struct PlanetsView: View {

    @State private var selectedTab: Tab?
    @Environment(\.colorScheme) private var scheme
    @State private var tabProgress: CGFloat = 0
    var body: some View {
        
        NavigationStack {
            VStack {
                CustomTabBar()
                    .padding(.top)
                
                GeometryReader {
                    let size = $0.size
                    
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 0) {
                            ScrollView(.vertical) {
                                ForEach(innerPlanets) { planet in
                                    PlanetBlock(planet: planet)
                                }
                                .onTapGesture {
                                    Haptics.shared.vibrate(for: .success)
                                }
                            }
                            .listStyle(PlainListStyle())  // Use PlainListStyle here
                            .id(Tab.inner)
                            .containerRelativeFrame(.horizontal)
                            .onAppear(perform: {Haptics.shared.impact(for: .light)})
                            
                            ScrollView(.vertical) {
                                ForEach(outerPlanets) { planet in
                                    PlanetBlock(planet: planet)
                                }
                                .onTapGesture {
                                    Haptics.shared.vibrate(for: .success)
                                }
                            }
                            .id(Tab.outer)
                            .containerRelativeFrame(.horizontal)
                            .onAppear(perform: {Haptics.shared.impact(for: .light)})
                            
                            ScrollView(.vertical) {
                                VStack {
                                    Image("solar-system")
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                        .padding(.bottom, 8)
                                    
                                    Text("Coming Soon!")
                                        .font(Font.custom("SF Pro Rounded Semibold", size: 24))

                                    Text("Get ready to explore the solar system like never before with our upcoming 3D and AR model for the whole solar system. Stay tuned!")
                                        .font(Font.custom("SF Pro Rounded Regular", size: 18))
                                        .foregroundStyle(.secondary)
                                        .padding([.leading, .trailing])
                                        .padding(.top, 8)
                                }
                                .padding()
                                .padding(.top, 32)
                            }
                            .id(Tab.solar)
                            .containerRelativeFrame(.horizontal)
                            .onAppear(perform: {Haptics.shared.impact(for: .light)})
                        }
                        .scrollTargetLayout()
                        .offsetX { value in
                            let progress = -value / (size.width * CGFloat(Tab.allCases.count - 1))
                            tabProgress = max(min(progress, 1), 0)
                        }
                    }
                    .scrollPosition(id: $selectedTab)
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.paging)
                    .scrollClipDisabled()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle("Planets")
            .onAppear {
                UINavigationBar.appearance().largeTitleTextAttributes = [
                    .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont.systemFont(ofSize: 34, weight: .semibold),
                ]
            }
        }
    }
    
    @ViewBuilder
    func CustomTabBar() -> some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                HStack(spacing: 10) {
                    Image(tab.image)
                        .resizable()
                        .frame(width: 25, height: 25)
                    Text(tab.rawValue)
                        .font(Font.custom("SF Pro Rounded Medium", size: 18))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .contentShape(.capsule)
                .onTapGesture {
                    withAnimation(.snappy) {
                        selectedTab = tab
                    }
                }
            }
        }
        .tabMask(tabProgress)
        .background {
            GeometryReader {
                let size = $0.size
                let capsuleWidth = size.width / CGFloat(Tab.allCases.count)
                
                Capsule()
                    .fill(scheme == .dark ? .black : .gray.opacity(0.1))
                    .frame(width: capsuleWidth)
                    .offset(x: tabProgress * (size.width - capsuleWidth))
            }
        }
        .background(.gray.opacity(0.1), in: .capsule)
        .padding(.horizontal, 15)
    }
        
}

struct PlanetBlock: View {
    var planet: Planet
    
    var body: some View {
        NavigationLink(destination: PlanetView(planet: planet)) {
            HStack(spacing: 16) {
                Image(planet.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .padding(.leading, 4)
                
                VStack() {
                    HStack {
                        Text(planet.name)
                            .font(Font.custom("SF Pro Rounded Medium", size: 20))
                        Spacer()
                    }

                    HStack {
                        Text(planet.description)
                            .font(Font.custom("SF Pro Rounded Regular", size: 16))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
                
                Image(systemName: "chevron.right")
                    .padding()
            }
            .padding()
        }
    }
}


#Preview {
    PlanetsView()
}
