//  ========================================
//  PlanetNode.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 12/30/22.
//  Abstract: A SCNNode class which gets attached into Planet3D
//  ========================================

import UIKit
import SceneKit

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
