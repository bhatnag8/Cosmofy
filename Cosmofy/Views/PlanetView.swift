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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("First Human Visual Observation")
                            .font(Font.custom("SF Pro Rounded Medium", size: 15))
                            .foregroundColor(.secondary)
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
                        SceneKitView()
                            .frame(height: 300)
                            .background(Color.black)
                            .cornerRadius(30)
                            .padding(8)

                        
                        VStack {
                            HStack {
                                Spacer()
                                Button(action: {
                                    
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
                                Text("Density")
                                    .font(Font.custom("SF Pro Rounded Medium", size: 16))
                                    .foregroundColor(.secondary)
                                HStack(alignment: .firstTextBaseline) {
                                    Text(String(planet.density)).font(Font.custom("SF Pro Rounded Semibold", size: 20))
                                    Text("g/cm³").font(Font.custom("SF Pro Rounded Semibold", size: 16)).foregroundStyle(planet.color)
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
                }
                .padding()
            }
            .navigationTitle(planet.name)
            .onAppear {
                UINavigationBar.appearance().largeTitleTextAttributes = [
                    .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont.systemFont(ofSize: 32),
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
    }
}

// This would be your actual implementation with data binding, MapKit integration, etc.

struct SceneKitView: UIViewControllerRepresentable {
    
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
        let neptune = PlanetNode(radius: 1, planet: "neptune", rotation: 10)
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
