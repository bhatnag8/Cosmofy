//  ========================================
//  PlanetNode.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 12/30/22.
//  Abstract: A SCNNode class which gets attached into Planet3D
//  ========================================

import UIKit
import SceneKit
import ARKit
import SwiftUI

class PlanetNode: SCNNode {
    
    var global = 0.0
    
    init(radius: Double, planet: String, rotation: Double, axialTilt: Double) {
        super.init()
        
        self.position = SCNVector3(0, 0, 0)
        global = rotation
        
        switch(planet) {
            case "mercury": createPlanet(planet: "Mercury", semiMajorAxis: 1.0, semiMinorAxis: 1.0, axialTilt: axialTilt); break
            case "venus": createPlanet(planet: "Venus", semiMajorAxis: 1.0, semiMinorAxis: 1.0, axialTilt: axialTilt); break
            case "earth":
                createPlanet(planet: "Earth", semiMajorAxis: 1.0, semiMinorAxis: 1.0, axialTilt: axialTilt)
                self.geometry?.firstMaterial?.specular.contents = UIImage(named: "map-earth-specular")
                self.geometry?.firstMaterial?.emission.contents = UIImage(named: "map-earth-emission")
                self.geometry?.firstMaterial?.normal.contents = UIImage(named: "map-earth-normal")
                break
            case "mars": createPlanet(planet: "Mars", semiMajorAxis: 1.0, semiMinorAxis: 1.0, axialTilt: axialTilt); break
            case "jupiter": createJupiter(axialTilt: axialTilt); break
            case "saturn": createSaturn(axialTilt: axialTilt); break
            case "uranus": createPlanet(planet: "Uranus", semiMajorAxis: 1.0, semiMinorAxis: 0.97, axialTilt: axialTilt); break
            case "neptune": createPlanet(planet: "Neptune", semiMajorAxis: 1.0, semiMinorAxis: 0.97, axialTilt: axialTilt); break
            default: break
        }
        
        startRotation()
    }
    
    func createPlanet(planet: String, semiMajorAxis: Double, semiMinorAxis: Double, axialTilt: Double) {
        let sphereGeometry = SCNSphere(radius: 1.0)
        sphereGeometry.segmentCount = 72
        let sphereNode = SCNNode(geometry: sphereGeometry)
        
        // Apply scaling to the sphere node to deform it into an ellipsoid
        sphereNode.scale = SCNVector3(x: Float(semiMajorAxis), y: Float(semiMinorAxis), z: Float(1.0))
        
        // Apply axial tilt
        sphereNode.eulerAngles = SCNVector3(x: 0, y: 0, z: Float(axialTilt * .pi / 180))
        
        // Apply textures or materials as needed
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "map-\(planet.lowercased())")
        material.diffuse.mipFilter = SCNFilterMode.linear
        sphereGeometry.materials = [material]
        
        self.addChildNode(sphereNode)
    }
    
    func createJupiter(axialTilt: Double) {
        createPlanet(planet: "Jupiter", semiMajorAxis: 1.0, semiMinorAxis: 0.935, axialTilt: axialTilt)
    }
    
    func createSaturn(axialTilt: Double) {
        createPlanet(planet: "Saturn", semiMajorAxis: 1.0, semiMinorAxis: 0.902, axialTilt: axialTilt)
    }
    
    func stopRotation() {
        self.removeAllActions()
    }
    
    func startRotation() {
        let action = SCNAction.rotateBy(x: 0, y: 0.6, z: 0, duration: global)
        let repeatAction = SCNAction.repeatForever(action)
        self.runAction(repeatAction)
    }
    
    func setRotation(r: Double) {
        global = r
    }
    
    required init?(coder x: NSCoder) {
        super.init(coder: x)
    }
}

struct SceneKitView: UIViewControllerRepresentable {
    var planet: String
    
    var width: CGFloat?
    var height: CGFloat?
    var isFullScreen: Bool = false
    var stars: Bool
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let sceneView = SCNView()
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(sceneView)
        
        if isFullScreen {
            NSLayoutConstraint.activate([
                sceneView.leftAnchor.constraint(equalTo: viewController.view.leftAnchor),
                sceneView.rightAnchor.constraint(equalTo: viewController.view.rightAnchor),
                sceneView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
                sceneView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                sceneView.widthAnchor.constraint(equalToConstant: width ?? 300),
                sceneView.heightAnchor.constraint(equalToConstant: height ?? 300),
                sceneView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
                sceneView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor)
            ])
        }
        
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.backgroundColor = UIColor.black
        
        // Axial tilts for planets
        let axialTilts: [String: Double] = [
            "mercury": -0.034,
            "venus": -177.4,
            "earth": -23.4,
            "mars": -25.2,
            "jupiter": -3.1,
            "saturn": -26.7,
            "uranus": -97.8,
            "neptune": -28.3
        ]
        
        let planetNode = PlanetNode(
            radius: 1,
            planet: planet,
            rotation: 10,
            axialTilt: axialTilts[planet.lowercased()] ?? 0.0
        )
        planetNode.position = SCNVector3(0, 0, 0) // Center the node
        scene.rootNode.addChildNode(planetNode)
        
        if planet == "saturn" {
            let saturnLoop = SCNBox(width: 4.444, height: 0, length: 5.556, chamferRadius: 0)
            let material = SCNMaterial()
            material.diffuse.contents = UIImage(named:"map-saturn-ring")
            saturnLoop.materials = [material]
            let loopNode = SCNNode(geometry: saturnLoop)
            loopNode.position = SCNVector3(x: 0, y: 0, z: 0)
            loopNode.eulerAngles = SCNVector3(x: 0, y: 0, z: Float(-26.7 * .pi / 180))
            planetNode.addChildNode(loopNode)
        }
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
        if isFullScreen {
            if planet == "saturn" {
                cameraNode.position = SCNVector3(x: 0, y: 3, z: 10)
                cameraNode.eulerAngles = SCNVector3(x: -Float.pi / 10, y: 0, z: 0)
            } else {
                cameraNode.position = SCNVector3(x: 0, y: 0, z: 7)
            }
        } else {
            if planet == "saturn" {
                cameraNode.position = SCNVector3(x: 0, y: 1.5, z: 5.5)
                cameraNode.eulerAngles = SCNVector3(x: -Float.pi / 10, y: 0, z: 0)
            } else {
                cameraNode.position = SCNVector3(x: 0, y: 0, z: 3.5)
            }
        }

        if stars {
            let starsParticleSystem = SCNParticleSystem(named: "StarsParticleSystem.scnp", inDirectory: nil)!
            scene.rootNode.addChildNode(cameraNode)
            scene.rootNode.addParticleSystem(starsParticleSystem)
        }
        
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

struct ARKitView: UIViewControllerRepresentable {
    var planet: String
    var stars: Bool

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let sceneView = ARSCNView()
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(sceneView)
        
        NSLayoutConstraint.activate([
            sceneView.leftAnchor.constraint(equalTo: viewController.view.leftAnchor),
            sceneView.rightAnchor.constraint(equalTo: viewController.view.rightAnchor),
            sceneView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            sceneView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
        ])

        let scene = SCNScene()
        sceneView.scene = scene
        
        // Configure AR session
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        sceneView.session.run(configuration)
        
        // Add planets
        let axialTilts: [String: Double] = [
            "mercury": 0.034,
            "venus": 177.4,
            "earth": -23.4,
            "mars": 25.2,
            "jupiter": 3.1,
            "saturn": 26.7,
            "uranus": 97.8,
            "neptune": 28.3
        ]
        
        let planetNode = PlanetNode(
            radius: 1,
            planet: planet,
            rotation: 10,
            axialTilt: axialTilts[planet.lowercased()] ?? 0.0
        )
        planetNode.position = SCNVector3(0, -0.5, -5) // Position 1 meter in front of the camera
        scene.rootNode.addChildNode(planetNode)
        
        if planet == "saturn" {
            let saturnLoop = SCNBox(width: 4.444, height: 0, length: 5.556, chamferRadius: 0)
            let material = SCNMaterial()
            material.diffuse.contents = UIImage(named: "map-saturn-ring")
            saturnLoop.materials = [material]
            let loopNode = SCNNode(geometry: saturnLoop)
            loopNode.position = SCNVector3(x: 0, y: 0, z: 0)
            loopNode.eulerAngles = SCNVector3(x: 0, y: 0, z: Float(26.7 * .pi / 180))
            planetNode.addChildNode(loopNode)
        }

        // Add stars if enabled
        if stars {
            let starsParticleSystem = SCNParticleSystem(named: "StarsParticleSystem.scnp", inDirectory: nil)!
            scene.rootNode.addParticleSystem(starsParticleSystem)
        }
        
        sceneView.pointOfView = scene.rootNode.childNodes.first
        sceneView.autoenablesDefaultLighting = true
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Update the UI when state changes
    }
    
    typealias UIViewControllerType = UIViewController
}
