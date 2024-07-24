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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        VStack {
                            HStack {
                                Text("First Human Visual Observation")
                                    .font(Font.custom("SF Pro Rounded Medium", size: 16))
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            
                            
                            HStack {
                                Text(planet.visual)
                                    .font(Font.custom("SF Pro Rounded Medium", size: 16))
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                        }
                        
                        Spacer()
                        ZStack {
                            Circle()
                                .stroke(planet.color, lineWidth: 5)
                            Text(planet.order)
                                .font(.headline)
                        }
                        .frame(width: 50, height: 50)
                        
                        
                        
                        //                        Gauge(value: Double((allPlanets.firstIndex(of: planet)!)), in : 0...7) {
                        //
                        //                        } currentValueLabel: {
                        //                            Text(planet.order)
                        //                                .font(.headline)
                        //                        } minimumValueLabel: {
                        //
                        //                        } maximumValueLabel: {
                        //
                        //                        }
                        //                        .tint(Gradient(colors: [/*.yellow,*/ planet.color]))
                        //                        .gaugeStyle(AccessoryCircularGaugeStyle())
                    }
                    //                    .padding(.horizontal)
                    
                    
//                    HStack() {
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("Atmosphere")
//                                .font(Font.custom("SF Pro Rounded Medium", size: 16))
//                                .foregroundColor(.secondary)
//                            ScrollView(.horizontal, showsIndicators: false) {
//                                HStack() {
//                                    ForEach(Array(planet.atmosphere.enumerated()), id: \.element) { index, image in
//                                        Image(image)
//                                            .resizable()
//                                            .frame(width: 40, height: 40)
//                                            .cornerRadius(8)
//                                    }
//                                }
//                            }
//                        }
//                        .padding(.horizontal)
//                        Spacer()
//                    }
                    
                    HStack {
                        
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    
                    
                    Spacer(minLength: 20)
                    ZStack {
                        //                        SceneKitView(planet: planet.name.lowercased(), stars: false)
                        //                            .frame(height: 300)
                        //                            .background(Color.black)
                        //                            .cornerRadius(30)
                        //                            .padding(8)
                        
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
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Atmosphere")
                                .font(Font.custom("SF Pro Rounded Medium", size: 16))
                                .foregroundColor(.secondary)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack() {
                                    ForEach(planet.atmosphere) { atmos in
                                        AtmosphereView(planet: planet, atmosphere: atmos)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        Spacer()
                    }
                    
                    
                    HStack {
                        Text("Average Temperatures of Planets")
                            .font(Font.custom("SF Pro Rounded Medium", size: 16))
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        Spacer()
                    }
                    .padding(.top, 8)
                    
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
                                
                                //                            print("==========")
                                //                            print(geometry.frame(in: .global).minY)
                                //                            print(geometry.frame(in: .global).midY)
                                //                            print(geometry.frame(in: .global).maxY)
                                //                            print("==========")
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
//                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding()

                        
                        
                        
                        
                    }
                    
                    
                    HStack {
                        Text("Planets farther from the Sun have lower temperatures, highlighting the impact of solar distance on planetary climates.")
                            .font(Font.custom("SF Pro Rounded Regular", size: 12))
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    
                    
                    //                    Text("")
                    
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


/*
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
 
 */
#Preview {
    PlanetView(planet: venusPlanet)
}

//                            .foregroundStyle(planet.name == $0.name ? $0.color.gradient : Color.black.opacity(0.5).gradient)


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
