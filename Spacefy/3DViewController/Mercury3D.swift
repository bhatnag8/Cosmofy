//  ========================================
//  Mercury3D.swift
//  Spacefy
//  4th Edition
//  Created by Arryan Bhatnagar on 12/29/22.
//  ========================================

import UIKit
import SceneKit

class Mercury3D: UIViewController {
    
    @IBOutlet weak var sceneView: SCNView!
    var planetNode = MercuryNode(rotation: 1)
    
    @IBAction func pauseButton(_ sender: UIButton) {
        planetNode.stopRotation()
    }
    
    @IBAction func playButton(_ sender: Any) {
        planetNode.startRotation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = SCNScene()
        let node = SCNNode()
        let camera = SCNCamera()
        let starsParticleSystem = SCNParticleSystem(named: "StarsParticleSystem.scnp", inDirectory: nil)!
        
        node.camera = camera
        node.position = SCNVector3(0, 0, 5)
        scene.rootNode.addChildNode(node)
        scene.rootNode.addParticleSystem(starsParticleSystem)
        scene.rootNode.addChildNode(planetNode)
        
        sceneView.scene = scene
        sceneView.backgroundColor = UIColor.black
        sceneView.allowsCameraControl = true
        sceneView.showsStatistics = true
        
    }
    
}
