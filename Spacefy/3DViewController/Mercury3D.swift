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
    let scene = SCNScene()
    let node = SCNNode()
    let camera = SCNCamera()
    let starsParticleSystem = SCNParticleSystem(named: "StarsParticleSystem.scnp", inDirectory: nil)!
    
    var planetNode = MercuryNode(rotation: 16)
    
    
    @IBOutlet weak var playButton: UIButton!
    var pause = false
    @IBAction func playButton(_ sender: Any) {
        if (pause == false) {
            pause = true
            planetNode.stopRotation()
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            pause = false
            planetNode.startRotation()
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)

        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        node.camera = camera
        node.position = SCNVector3(0, 0, 5)
        scene.rootNode.addChildNode(node)
        scene.rootNode.addParticleSystem(starsParticleSystem)
        scene.rootNode.addChildNode(planetNode)
        
        sceneView.scene = scene
        sceneView.backgroundColor = UIColor.black
        sceneView.allowsCameraControl = true
        sceneView.cameraControlConfiguration.autoSwitchToFreeCamera = true
        sceneView.cameraControlConfiguration.allowsTranslation = true
        sceneView.cameraControlConfiguration.rotationSensitivity = 0.4
        
        playButton.layer.cornerRadius = 12
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "8K", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = UIColor.red

    }
    
}
