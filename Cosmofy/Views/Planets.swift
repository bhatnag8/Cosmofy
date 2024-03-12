//
//  Planets.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/11/24.
//

import SwiftUI

struct Planets: View {
    
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
                                VStack {
                                    Text("Inner Planets")
                                    Text("Inner Planets")
                                    Text("Inner Planets")
                                    Text("Inner Planets")
                                    Text("Inner Planets")
                                }
                            }
                            .id(Tab.inner)
                            .containerRelativeFrame(.horizontal)
                            
                            ScrollView(.vertical) {
                                VStack {
                                    Text("Outer Planets")
                                    Text("Outer Planets")
                                    Text("Outer Planets")
                                    Text("Outer Planets")
                                    Text("Outer Planets")
                                }
                            }
                            .id(Tab.outer)
                            .containerRelativeFrame(.horizontal)
                            
                            ScrollView(.vertical) {
                                VStack {
                                    Text("Solar System")
                                    Text("Solar System")
                                    Text("Solar System")
                                    Text("Solar System")
                                    Text("Solar System")

                                    
                                }
                            }
                            .id(Tab.solar)
                            .containerRelativeFrame(.horizontal)
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
                    .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont.systemFont(ofSize: 32),
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

#Preview {
    Planets()
}
