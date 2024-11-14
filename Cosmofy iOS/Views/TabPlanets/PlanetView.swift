//
//  Planet.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 2/9/24.
//

import SwiftUI
import SceneKit
import Charts


struct PlanetView: View {
    
    var planet: Planet
    @State private var planets: [Planet] = allPlanets
    @State private var isAnimated: Bool = false
    
    @State private var isPresented = false
    @Environment(\.colorScheme) var colorScheme
    @State var loadedChart = false
    
    @Binding var complete: Bool
    @Binding var failed: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                // MARK: Section 1
                HStack {
                    VStack {
                        HStack {
                            Text("First Human Visual Observation")
                                .fontDesign(.rounded)
//                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        HStack {
                            Text(planet.visual)
                                .fontDesign(.rounded)
//                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                    }
                    Spacer()
                    ZStack {
                        Circle()
                            .stroke(planet.color, lineWidth: 4)
                        Text(planet.order)
                            .fontDesign(.rounded)
                            .font(.headline)
                    }
                    .frame(width: 44, height: 44)
                }
                .padding()
                                    
                planetModel
                    .padding(.horizontal, 24)
                
                
                HStack {
                    Text(planet.expandedDescription)
                        .fontDesign(.serif)
                        .italic()
//                        .textSelection(.enabled)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                        .padding(.top)
                    Spacer()
                }
                .padding()
                
                if planet == earthPlanet {
                    NavView(
                        view: RNNMaybach(complete: $complete, failed: $failed),
                        imageName: "home-icon-4",
                        title: "Nature Scope",
                        subtitle: "View natural events and disasters around the globe"
                    )
                }
                
                VStack {
                    HStack {
                        Text("planetary facts")
                            .textCase(.uppercase)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    Divider()
                }
                .padding(.horizontal, 32)
                .padding(.top)
                

                HStack {
                    PlanetPropertyView(title: "Natural Satellites", value: String(planet.moons), unit: "moons", color: planet.color)
                    PlanetPropertyView(title: "Planetary Rings", value: String(planet.rings), unit: "rings", color: planet.color)
                }
                .padding(.horizontal, 32)
                .padding(.top, 16)
                
                HStack {
                    PlanetPropertyView(title: "Gravity", value: String(planet.gravity), unit: "m/s²", color: planet.color)
                    PlanetPropertyView(title: "Escape Velocity", value: planet.escapeVelocity, unit: "km/h", color: planet.color)
                }
                .padding(.horizontal, 32)
                .padding(.top, 8)

                PlanetPropertyView(title: "Equatorial Radius", value: planet.radius, unit: "km", color: planet.color)
                .padding(.horizontal, 32)
                .padding(.top, 8)

                PlanetPropertyView(title: "Mass", value: planet.mass, unit: "kg", color: planet.color)
                    .padding(.horizontal, 32)
                    .padding(.top, 8)


                PlanetPropertyView(title: "Volume", value: planet.volume, unit: "km³", color: planet.color)
                    .padding(.horizontal, 32)
                    .padding(.top, 8)

                
                HStack() {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Atmosphere")
                            .fontDesign(.rounded)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack() {
                                ForEach(planet.atmosphere) { atmos in
                                    AtmosphereView(planet: planet, atmosphere: atmos)
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 32)
                .padding(.top, 8)


                
                HStack {
                    Text("Average Temperatures of Planets")
                        .fontDesign(.rounded)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal, 32)

                
                ZStack {
                    GeometryReader { geometry in
                        Chart(planets) {
                            //                            RuleMark(x: .value("Temperature", 0))
                            BarMark(
                                x: .value("Temperature", $0.isAnimated ? $0.averageTemperature : 0),
                                y: .value("Name", $0.name)
                            )
//                                .foregroundStyle($0.color.gradient)
                            .foregroundStyle(planet.name == $0.name ? $0.color.gradient : $0.color.opacity(0.2).gradient)
                            
                        }
                        .foregroundStyle(.black)
                        .fontDesign(.rounded)
                        .chartXScale(domain: -300...500)
                        .padding(.horizontal)
                        .onChange(of: geometry.frame(in: .global).minY) {
                            if geometry.frame(in: .global).maxY < 900 {
                                loadedChart = true
                            }
                        }
                        .onChange(of: loadedChart) { oldValue, newValue in
                            if loadedChart == true {
                                animateChart()
                            }
                        }
                    }
                    .frame(height: 400)
                    
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            VStack {
                                
                                Gauge(value: Float(planet.averageTemperature + 273), in : 0...1000) {
                                    Text("K")
                                } currentValueLabel: {
                                    Text("\(planet.averageTemperature + 273)")
                                        .font(.headline)
                                }
                                .background(.BETRAY)
                                .tint(Gradient(colors: [planet.color.opacity(0.7), planet.color, planet.color.opacity(0.75)]))
                                .gaugeStyle(AccessoryCircularGaugeStyle())
                                .padding(.horizontal)
                                
                                Gauge(value: Float(planet.averageTemperature), in : -280...600) {
                                    Text("°C")
                                } currentValueLabel: {
                                    Text("\(planet.averageTemperature)")
                                        .font(.headline)
                                }
                                .background(.BETRAY)
                                .tint(Gradient(colors: [planet.color.opacity(0.7), planet.color, planet.color.opacity(0.75)]))
                                .gaugeStyle(AccessoryCircularGaugeStyle())
                                .padding([.bottom, .horizontal])
                            }
                            
                            
                        }
                    }
                    .padding()
                }
                .padding(.horizontal)
                .padding(.top, 8)

                
                
                HStack {
                    Text("Planets farther from the Sun have lower temperatures, highlighting the impact of solar distance on planetary climates.")
                        .fontDesign(.rounded)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Spacer()
                }
                .padding(.horizontal, 32)
                .padding(.top, 8)
                
            }
//            .background(colorScheme == .dark ? Color.init(hex: 0x0F0F15) : Color.clear)
            // 0F0F15 0x181C22
            .navigationTitle(planet.name)
//            .onAppear {
//                UINavigationBar.appearance().largeTitleTextAttributes = [
//                    .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont.systemFont(ofSize: 34, weight: .semibold),
//                ]
//            }
            .navigationBarItems(
                trailing: ShareLink(item: URL(string: "https://apps.apple.com/app/cosmofy/id6450969556")!, preview: SharePreview("Cosmofy on the Apple App Store", image: Image("iconApp")))
                    .foregroundStyle(planet.color)
            )
            
            
        }
        
    }
    
    private var planetModel: some View {
        ZStack {
            SceneView(
                scene: createPlanetScene(planetName: planet.name.lowercased(), isFullScreen: false, platform: nil).scene,
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
                    .padding(4)
                    
                    .fullScreenCover(isPresented: $isPresented) {
                        SomeView(planet: planet)
                    }
                }
                Spacer()
            }
            
            VStack {
                Spacer()
                HStack {
                    Text("SceneKit")
                        .fontDesign(.rounded)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding([.bottom, .leading], 20)
                    Spacer()
                }
            }
            Spacer()
        }
    }
    
    private func animateChart() {
        guard !isAnimated else { return }
        isAnimated = true
        
        $planets.enumerated().forEach { index, element in
            let delay = Double(index) * 0.05
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                withAnimation(.smooth) {
                    element.wrappedValue.isAnimated = true
                }
            })
        }
    }
}

struct AtmosphereView: View {
    var planet: Planet
    var atmosphere: Atmosphere
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(planet.color.gradient)

            VStack {
                HStack {
                    Spacer()
                    Text(atmosphere.molar)
                        .font(.caption2)
                        .fontDesign(.rounded)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
                .padding(.trailing, 3)
                .padding(.top, 3)
                
                HStack {
                    Text(atmosphere.formula)
                        .fontDesign(.rounded)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.leading, 2)
                .padding(.bottom, 3)
                
            }
        }
        .frame(width: 42, height: 42)
        .cornerRadius(8)
    }
}


struct PlanetPropertyView: View {
    var title: String
    var value: String
    var unit: String
    var color: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontDesign(.rounded)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                
                HStack(alignment: .firstTextBaseline) {
                    Text(value).foregroundStyle(.BETRAYED)
                        .font(.title2)
                        .fontDesign(.rounded)
                        .fontWeight(.semibold)
                    
                    if (unit == "moons" && value == "1") {
                        Text("moon")
                            .fontDesign(.rounded)
                            .fontWeight(.medium)
                            .foregroundStyle(color)

                    } else {
                        Text(unit)
                            .fontDesign(.rounded)
                            .fontWeight(.medium)
                            .foregroundStyle(color)
                    }
                }
            }
            Spacer()
        }
    }
}
