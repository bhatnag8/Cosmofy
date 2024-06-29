//
//  iPadPlanetView.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 6/28/24.
//

import Foundation
import SwiftUI
import SceneKit

struct iPadPlanetView: View {
    
    var planet: Planet
    @State private var isPresented = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    ZStack {
//                        SceneKitView(planet: planet.name.lowercased(), stars: false)
//                            .frame(maxHeight: .infinity)
//                            .background(Color.black)
//                            .cornerRadius(30)
//                            .padding(8)
                        
                        SceneView(
                            scene: createPlanetScene(planetName: planet.name.lowercased(), isFullScreen: false),
                            options: [.allowsCameraControl, .autoenablesDefaultLighting]
                        )
                        .frame(maxHeight: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .edgesIgnoringSafeArea(.all)
                        
                        VStack {
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.isPresented.toggle()
                                }) {
                                    HStack {
                                        Image(systemName: "arrow.down.left.and.arrow.up.right")
                                            .foregroundColor(.white)
                                            .padding(8)
                                            .background(Color.white.opacity(0.15))
                                            .clipShape(RoundedRectangle(cornerRadius: 12))

                                    }
                                    .padding()
                                    
                                }
                                .padding(8)
                                
                                .fullScreenCover(isPresented: $isPresented) {
                                    SomeView(planet: planet)
                                }

                            }
                            
                            
                            Spacer()
                        }

                        
                        VStack {
                            Spacer()
                            HStack {
                                Text(" SceneKit")
                                    .font(Font.custom("SF Pro Rounded Semibold", size: 22))
                                    .foregroundColor(.white)
                                    .padding([.bottom], 20)
                                    .padding([.leading], 24)
                                Spacer()
                            }
                            
                        }
                        Spacer()
                    }
                    VStack {
                        VStack {
                            HStack {
                                if !(planet.name == "Earth") {
                                    Text("First Human Visual Observation")
                                        .font(Font.custom("SF Pro Rounded Regular", size: 16))
                                        .foregroundColor(.secondary)
                                } else {
                                    Text("Earth was always perceived as a planet")
                                        .font(Font.custom("SF Pro Rounded Regular", size: 16))
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            HStack {
                                Text(planet.visual)
                                    .font(Font.custom("SF Pro Rounded Regular", size: 16))
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .padding()
                        
                        HStack {
                            Text(planet.expandedDescription)
                                .textSelection(.enabled)
                                .multilineTextAlignment(.leading)
                                .italic()
                                .font(.body)
                                .fontDesign(.serif)
                                .padding(.horizontal)
                            Spacer()
                        }
                        .padding(.horizontal)

                        VStack(spacing: 16) {
                            
                            HStack {
                                PlanetPropertyView(title: "Natural Satellites", value: String(planet.moons), unit: "moons", color: planet.color)
                                PlanetPropertyView(title: "Planetary Rings", value: String(planet.rings), unit: "rings", color: planet.color)
                            }

                            
                            HStack {
                                PlanetPropertyView(title: "Gravity", value: String(planet.gravity), unit: "m/s²", color: planet.color)
                                PlanetPropertyView(title: "Escape Velocity", value: planet.escapeVelocity, unit: "km/h", color: planet.color)
                            }
                            
                            PlanetPropertyView(title: "Equatorial Radius", value: planet.radius, unit: "km", color: planet.color)
                            PlanetPropertyView(title: "Mass", value: planet.mass, unit: "kg", color: planet.color)
                            PlanetPropertyView(title: "Volume", value: planet.volume, unit: "km³", color: planet.color)
                            
                            HStack() {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Atmosphere")
                                        .font(Font.custom("SF Pro Rounded Medium", size: 16))
                                        .foregroundColor(.secondary)
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack() {
                                            ForEach(Array(planet.atmosphere.enumerated()), id: \.element) { index, image in
                                                Image(image)
                                                    .resizable()
                                                    .frame(width: 40, height: 40)
                                                    .cornerRadius(8)
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                Spacer()
                            }

                        }
                        .padding()
                    }
                    .padding(.horizontal)


                }
                .padding()
            }
            .background(colorScheme == .dark ? Color.init(hex: 0x0F0F15) : Color.clear) // Apply background only in dark mode
            // 0F0F15 0x181C22
            .navigationTitle(planet.name)
            .onAppear {
                UINavigationBar.appearance().largeTitleTextAttributes = [
                    .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont.systemFont(ofSize: 34, weight: .semibold),
                ]
            }
            .navigationBarItems(
                trailing: ShareLink(item: URL(string: "https://apps.apple.com/app/cosmofy/id6450969556")!, preview: SharePreview("Cosmofy on the Apple App Store", image: Image("iconApp")))
                    .foregroundStyle(planet.color)
            )
        }
    }
}


#Preview {
    iPadPlanetView(planet: neptunePlanet)
}

