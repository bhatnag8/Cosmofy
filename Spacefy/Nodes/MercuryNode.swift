//  ========================================
//  MercuryNode.swift
//  Spacefy
//  4th Edition
//  Created by Arryan Bhatnagar on 12/30/22.
//  ========================================

import UIKit
import SceneKit

class MercuryNode : SCNNode {
    
    var global = 0.0
    
    init(rotation : Double) {
        super.init()
        let sphere = SCNSphere(radius: 1.25)
        global = rotation

        sphere.firstMaterial?.diffuse.contents = UIImage(named: "20221230_MercuryMap")
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
    
    
    
    
    
    required init?(coder x: NSCoder) {
        super.init(coder: x)
    }
   
    
}
