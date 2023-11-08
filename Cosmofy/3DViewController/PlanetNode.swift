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
        
        let sphere = SCNSphere(radius: radius)
        
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
            case "jupiter": image = UIImage(named: "")!; break
            case "saturn": SaturnInterrupt(); break;
            case "uranus": image = UIImage(named: "")!; break
            case "neptune": image = UIImage(named: "")!; break
            default: break
        }
        sphere.firstMaterial?.diffuse.contents = image
        sphere.firstMaterial?.diffuse.mipFilter = SCNFilterMode.linear
        sphere.segmentCount = 72
        
        self.geometry = sphere
        
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
