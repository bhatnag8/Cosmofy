//
//  Planet.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 2/9/24.
//

import SwiftUI
import SceneKit

struct Planet: View {
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Neptune")
                        .font(Font.custom("SF Pro Rounded Bold", size: 32))
                    Spacer()
                }
                Spacer()
                HStack{
                    Text("First Human Visual Observation")
                        .font(Font.custom("SF Pro Rounded Medium", size: 15))
                        .foregroundColor(.secondary)
                    Spacer()
                }
                HStack {
                    Text("Wednesday, September 23, 1846")
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
                                Text("14").font(Font.custom("SF Pro Rounded Semibold", size: 20))
                                Text("moons").font(Font.custom("SF Pro Rounded Semibold", size: 16)).foregroundStyle(.colorNeptune)
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
                                Text("5").font(Font.custom("SF Pro Rounded Semibold", size: 20))
                                Text("rings").font(Font.custom("SF Pro Rounded Semibold", size: 16)).foregroundStyle(.colorNeptune)
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
                                Text("11.15").font(Font.custom("SF Pro Rounded Semibold", size: 20))
                                Text("m/s²").font(Font.custom("SF Pro Rounded Semibold", size: 16)).foregroundStyle(.colorNeptune)
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
                                Text("1.638").font(Font.custom("SF Pro Rounded Semibold", size: 20))
                                Text("g/cm³").font(Font.custom("SF Pro Rounded Semibold", size: 16)).foregroundStyle(.colorNeptune)
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
                            Text("2.4622 × 10⁴").font(Font.custom("SF Pro Rounded Semibold", size: 20))
                            Text("km").font(Font.custom("SF Pro Rounded Semibold", size: 16)).foregroundStyle(.colorNeptune)
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
                            Text("1.0241 × 10²⁶").font(Font.custom("SF Pro Rounded Semibold", size: 20))
                            Text("kg").font(Font.custom("SF Pro Rounded Semibold", size: 16)).foregroundStyle(.colorNeptune)
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
                            Text("6.2526 × 10¹³").font(Font.custom("SF Pro Rounded Semibold", size: 20))
                            Text("km³").font(Font.custom("SF Pro Rounded Semibold", size: 16)).foregroundStyle(.colorNeptune)
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

                            Image("co2-symbol")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(8)
                            Image("n2-symbol")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(8)
                            Image("co2-symbol")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(6)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
 
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 200)
                    .padding(.horizontal)
            }
            .padding()

        }
        .navigationTitle("Neptune")
    }
}


struct MapView: View {
    var body: some View {
        // Placeholder view to represent the map
        Rectangle()
            .fill(Color.black)
            .cornerRadius(10)
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
        
//        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Update the UI when state changes
    }
    
    typealias UIViewControllerType = UIViewController
}

#Preview {
    Planet()
}
