//
//  Planet.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 2/9/24.
//

import SwiftUI
import SceneKit

struct SomeView: View {
    let backgroundGradient = LinearGradient(
        colors: [Color.cyan, Color.blue],
        startPoint: .top, endPoint: .bottom)
    @Environment (\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            backgroundGradient
            VStack {
    //            Text("HIIII")
    //            Text("HIIII")
    //            Text("HIIII")
            }
            .background(.red)
//            .edgesIgnoringSafeArea(.all)
            
        }
        .ignoresSafeArea()
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }

    }
    
    
}

struct PlanetView: View {
    
    var planet: Planet
    @State private var isPresented = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        if !(planet.name == "Earth") {
                            Text("First Human Visual Observation")
                                .font(Font.custom("SF Pro Rounded Medium", size: 15))
                                .foregroundColor(.secondary)
                        } else {
                            Text("Earth was perceived as a planet")
                                .font(Font.custom("SF Pro Rounded Medium", size: 15))
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                    HStack {
                        Text(planet.visual)
                            .font(Font.custom("SF Pro Rounded Medium", size: 15))
                            .foregroundColor(.secondary)
                        Spacer()
                    }

                    Spacer(minLength: 20)
                    ZStack {
                        SceneKitView(planet: planet.name.lowercased())
                            .frame(height: 300)
                            .background(Color.black)
                            .cornerRadius(30)
                            .padding(8)

                        
                        VStack {
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.isPresented.toggle()
                                    
                                }) {
                                    HStack {
                                        Image(systemName: "arrow.down.left.and.arrow.up.right") // The icon
                                    }
                                    .foregroundColor(.white)
                                    .padding()
                                    .clipShape(RoundedRectangle(cornerRadius: 500))
                                    .padding(.top, 16)
                                    .padding([.trailing], 16)
                                }
                                .fullScreenCover(isPresented: $isPresented, content: SomeView.init)
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
                }
                .padding()
                
                

                
                VStack(spacing: 16) {
                    
                    HStack {
                        // Left Column
                        VStack(alignment: .leading, spacing: 8) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Natural Satellites")
                                    .font(Font.custom("SF Pro Rounded Medium", size: 16))
                                    .foregroundColor(.secondary)
                                HStack(alignment: .firstTextBaseline) {
                                    Text(String(planet.moons)).font(Font.custom("SF Pro Rounded Semibold", size: 20))
                                    Text("moons").font(Font.custom("SF Pro Rounded Semibold", size: 16)).foregroundStyle(planet.color)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Right column
                        VStack(alignment: .leading, spacing: 8) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Planetary Rings")
                                    .font(Font.custom("SF Pro Rounded Medium", size: 16))
                                    .foregroundColor(.secondary)
                                HStack(alignment: .firstTextBaseline) {
                                    Text(String(planet.rings)).font(Font.custom("SF Pro Rounded Semibold", size: 20))
                                    Text("rings").font(Font.custom("SF Pro Rounded Semibold", size: 16)).foregroundStyle(planet.color)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        // Left Column
                        VStack(alignment: .leading, spacing: 8) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Gravity")
                                    .font(Font.custom("SF Pro Rounded Medium", size: 16))
                                    .foregroundColor(.secondary)
                                HStack(alignment: .firstTextBaseline) {
                                    Text(String(planet.gravity)).font(Font.custom("SF Pro Rounded Semibold", size: 20))
                                    Text("m/s²").font(Font.custom("SF Pro Rounded Semibold", size: 16)).foregroundStyle(planet.color)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Right column
                        VStack(alignment: .leading, spacing: 8) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Escape Velocity")
                                    .font(Font.custom("SF Pro Rounded Medium", size: 16))
                                    .foregroundColor(.secondary)
                                HStack(alignment: .firstTextBaseline) {
                                    Text(planet.escapeVelocity).font(Font.custom("SF Pro Rounded Semibold", size: 20))
                                    Text("km/h").font(Font.custom("SF Pro Rounded Semibold", size: 16)).foregroundStyle(planet.color)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal)
                    
                    
                    HStack() {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Equatorial Radius")
                                .font(Font.custom("SF Pro Rounded Medium", size: 16))
                                .foregroundColor(.secondary)
                            HStack(alignment: .firstTextBaseline) {
                                Text(planet.radius).font(Font.custom("SF Pro Rounded Semibold", size: 20))
                                Text("km").font(Font.custom("SF Pro Rounded Semibold", size: 16)).foregroundStyle(planet.color)
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    
                    
                    HStack() {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Mass")
                                .font(Font.custom("SF Pro Rounded Medium", size: 16))
                                .foregroundColor(.secondary)
                            HStack(alignment: .firstTextBaseline) {
                                Text(planet.mass).font(Font.custom("SF Pro Rounded Semibold", size: 20))
                                Text("kg").font(Font.custom("SF Pro Rounded Semibold", size: 16)).foregroundStyle(planet.color)
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack() {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Volume")
                                .font(Font.custom("SF Pro Rounded Medium", size: 16))
                                .foregroundColor(.secondary)
                            HStack(alignment: .firstTextBaseline) {
                                Text(planet.volume).font(Font.custom("SF Pro Rounded Semibold", size: 20))
                                Text("km³").font(Font.custom("SF Pro Rounded Semibold", size: 16)).foregroundStyle(planet.color)
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack() {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Atmosphere")
                                .font(Font.custom("SF Pro Rounded Medium", size: 16))
                                .foregroundColor(.secondary)
                            HStack(alignment: .firstTextBaseline) {
                                
                                ForEach(Array(planet.atmosphere.enumerated()), id: \.element) { index, image in
                                    Image(image)
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(8)
                                }

                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    Divider()
                    ChartView(planet: planet)
                        .padding(.horizontal, 12)
                }
                .padding()
            }
            .navigationTitle(planet.name)
            .onAppear {
                UINavigationBar.appearance().largeTitleTextAttributes = [
                    .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont.systemFont(ofSize: 34, weight: .semibold),
                ]
            }
            .navigationBarItems(
                trailing: Button(action: {
                    // Add your second trailing button action here
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .font(Font.custom("SF Pro Rounded", size: 20))
                        .foregroundColor(planet.color)
                }
            )
        }
        .onAppear(perform: {Haptics.shared.vibrate(for: .success)})
    }
}

struct SceneKitView: UIViewControllerRepresentable {
    var planet: String
    
    let width: CGFloat = 300
    let height: CGFloat = 300
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let sceneView = SCNView()
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(sceneView)
        NSLayoutConstraint.activate([
            sceneView.widthAnchor.constraint(equalToConstant: width),
            sceneView.heightAnchor.constraint(equalToConstant: height),
            sceneView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            sceneView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor)
        ])
        
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.backgroundColor = UIColor.black
        
        // Assuming you have a PlanetNode for Neptune
        let neptune = PlanetNode(radius: 1, planet: planet, rotation: 10)
        neptune.position = SCNVector3(0, 0, 0) // Center the node
        scene.rootNode.addChildNode(neptune)
        
        // Set up the camera, lighting, etc.
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 3.5)
        scene.rootNode.addChildNode(cameraNode)
        sceneView.pointOfView = cameraNode
        
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Update the UI when state changes
    }
    
    typealias UIViewControllerType = UIViewController
}


#Preview {
    PlanetView(planet: neptunePlanet)
}
