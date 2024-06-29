//
//  Planet.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 2/9/24.
//

import SwiftUI
import SceneKit

struct PlanetView: View {
    
    var planet: Planet
    @State private var isPresented = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ScrollView {
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
                    
                    HStack {
                        Text(planet.visual)
                            .font(Font.custom("SF Pro Rounded Regular", size: 16))
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    
                    
                    
                    Spacer(minLength: 20)
                    ZStack {
//                        SceneKitView(planet: planet.name.lowercased(), stars: false)
//                            .frame(height: 300)
//                            .background(Color.black)
//                            .cornerRadius(30)
//                            .padding(8)
                        
                        SceneView(
                            scene: createPlanetScene(planetName: planet.name.lowercased(), isFullScreen: false),
                            options: [.allowsCameraControl, .autoenablesDefaultLighting]
                        )
                        .frame(height: 300)
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
                                    .font(Font.custom("SF Pro Rounded Semibold", size: 18))
                                    .foregroundColor(.white)
                                    .padding([.bottom], 20)
                                    .padding([.leading], 24)
                                Spacer()
                            }
                            
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 8)
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

struct SomeView: View {
    let backgroundGradient = LinearGradient(
        colors: [Color.cyan, Color.blue],
        startPoint: .top, endPoint: .bottom)
    var planet: Planet
    
    @Environment (\.presentationMode) var presentationMode
    @State private var selectedViewType: Int = 0
    
    var body: some View {
        ZStack {
            /*
            VStack {
                switch selectedViewType {
                    case 0:
                        SceneKitView(planet: planet.name.lowercased(), isFullScreen: true, stars: true)
                            .background(Color.black)
                            .cornerRadius(30)
                            .onAppear(perform: {
                                Haptics.shared.impact(for: .light)
                            })
                            .background(.black)
                        
                        
                    /**
                    case 2:
                        ImagesView(planet: planet)
                            .padding(.top, 96)
                            .background(Color.black)
                    */

                    default:
                        Text("Selection not available")

                }
            }
            
            VStack {
                Picker("View Type", selection: $selectedViewType) {
                    Text("3D").tag(0)
//                    Text("AR").tag(1)
                /**
                    Text("Images").tag(2)

                    Scene becomes laggy with warning:
                    SCNView implements focusItemsInRect: - caching for linear focus movement is limited as long as this view is on screen.
                    Will fix in v1.2
                 **/
                }
                .environment(\.colorScheme, .dark)
                .pickerStyle(SegmentedPickerStyle())
                .padding(.top, 64)
                .padding(.horizontal, 96)
                Spacer()
            }
             */
            
//            SceneKitView(planet: planet.name.lowercased(), isFullScreen: true, stars: true)
//                .background(Color.black)
//                .cornerRadius(30)
//                .background(.black)
            
            SceneView(
                scene: createPlanetScene(planetName: planet.name.lowercased(), isFullScreen: true),
                options: [.allowsCameraControl, .autoenablesDefaultLighting]
            )
            .edgesIgnoringSafeArea(.all)

            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill") // The icon
                            .resizable()
                            .foregroundStyle(.white.opacity(0.7))
                            .frame(width: 30, height: 30)
                            .padding(.top, 64)
                            .padding(.trailing, 16)
                    }
                }
                Spacer()
            }
            
            
            
        }
        .ignoresSafeArea()

    }
    
}


#Preview {
    PlanetView(planet: mercuryPlanet)
}


struct PlanetPropertyView: View {
    var title: String
    var value: String
    var unit: String
    var color: Color
    @State private var topExpanded: Bool = true
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(Font.custom("SF Pro Rounded Medium", size: 16))
                    .foregroundColor(.secondary)
                HStack(alignment: .firstTextBaseline) {
                    Text(value).foregroundStyle(.BETRAYED)
                        .font(Font.custom("SF Pro Rounded Semibold", size: 20))
                    
                    if (unit == "moons" && value == "1") {
                        Text("moon").font(Font.custom("SF Pro Rounded Semibold", size: 16)).foregroundStyle(color)
                    } else {
                        Text(unit).font(Font.custom("SF Pro Rounded Semibold", size: 16)).foregroundStyle(color)
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}
