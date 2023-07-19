//  ========================================
//  MercuryNode.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 12/30/22.
//  Abstract: A SCNNode class which gets attached into Mercury3D
//  ========================================

import UIKit
import SceneKit

class MercuryNode : SCNNode {
    
    var global = 0.0
    
    init(rotation : Double) {
        super.init()
        
        let sphere = SCNSphere(radius: 1.2)
        
        global = rotation

        sphere.firstMaterial?.diffuse.contents = UIImage(named: "20221230_EarthMap_1")
        sphere.firstMaterial?.diffuse.mipFilter = SCNFilterMode.linear
        sphere.segmentCount = 72
        
        self.geometry = sphere
        
        startRotation()
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
