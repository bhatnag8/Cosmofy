//  ========================================
//  PlanetNode.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 12/30/22.
//  Abstract: A SCNNode class which gets attached into Planet3D
//  ========================================

import UIKit
import SceneKit

class PlanetNode : SCNNode {
    
    var global = 0.0
    
    init(radius: Double, planet: String, rotation : Double) {
        super.init()
        
        var shape = SCNSphere(radius: radius)
        
        global = rotation
        var image = UIImage()
        
        switch(planet) {
            case "mercury": image = UIImage(named: "MercuryMap")!; break
            case "venus": image = UIImage(named: "VenusMap")!; break
            case "earth": 
                image = UIImage(named:"e19")!
                self.geometry?.firstMaterial?.specular.contents = UIImage(named:"20221230_EarthMap_4")
                self.geometry?.firstMaterial?.emission.contents = UIImage(named:"20221230_EarthMap_3")
                self.geometry?.firstMaterial?.normal.contents = UIImage(named:"20221230_EarthMap_2")
                break
            case "mars": image = UIImage(named: "MarsMap")!; break
            case "jupiter": 
                // Define the dimensions of the ellipsoid
                let semiMajorAxis = 1.0 // Scale factor along the x-axis
                let semiMinorAxis = 0.935 // Scale factor along the y-axis
                let height = 1.0 // Scale factor along the z-axis
                            
                // Create an empty node to hold the ellipsoid
                let jupiterNode = SCNNode()
                
                // Create a sphere with a uniform radius
                let sphereGeometry = SCNSphere(radius: 1.0)
                sphereGeometry.segmentCount = 72
                let sphereNode = SCNNode(geometry: sphereGeometry)
                
                // Apply scaling to the sphere node to deform it into an ellipsoid
                sphereNode.scale = SCNVector3(x: Float(semiMajorAxis), y: Float(semiMinorAxis), z: Float(height))
                
                // Apply textures or materials as needed
                let jupiterMaterial = SCNMaterial()
                jupiterMaterial.diffuse.contents = UIImage(named: "JupiterMap")
                jupiterMaterial.diffuse.mipFilter = SCNFilterMode.linear

                sphereGeometry.materials = [jupiterMaterial]
                
                // Add the ellipsoidal sphere to the jupiterNode
                jupiterNode.addChildNode(sphereNode)
                
                // Add the jupiterNode to the PlanetNode
                self.addChildNode(jupiterNode)
                startRotation()
                return
                
            case "saturn": SaturnInterrupt(); break;
            case "uranus": image = UIImage(named: "")!; break
            case "neptune": image = UIImage(named: "")!; break
            default: break
        }
        shape.firstMaterial?.diffuse.contents = image
        shape.firstMaterial?.diffuse.mipFilter = SCNFilterMode.linear
        shape.segmentCount = 72
        
        self.geometry = shape
        
        startRotation()
    }
    
    
    func SaturnInterrupt() {
        
    }
    
    func stopRotation() {
        self.removeAllActions()
    }
    
    func startRotation() {
        let action = SCNAction.rotateBy(x: 0, y: 0.6, z: 0, duration: global)
        let repeatAction = SCNAction.repeatForever(action)
        self.runAction(repeatAction)
    }
    
    func setRotation(r : Double) {
        global = r
    }
    
    required init?(coder x: NSCoder) {
        super.init(coder: x)
    }

}
