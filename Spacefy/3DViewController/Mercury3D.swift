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
    
    var planetNode = MercuryNode(rotation: 6)
    
    
    @IBOutlet weak var playButton: UIButton!
    var pause = false
    @IBAction func playButton(_ sender: Any) {
        if (pause == false) {
            pause = true
            planetNode.stopRotation()
            playButton.setImage(UIImage(systemName: "play"), for: .normal)
        } else {
            pause = false
            planetNode.startRotation()
            playButton.setImage(UIImage(systemName: "pause"), for: .normal)

        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        camera.wantsHDR = true
        camera.wantsExposureAdaptation = false
        node.camera = camera
    
        node.position = SCNVector3(0, 0, 5)
        scene.rootNode.addChildNode(node)
        scene.rootNode.addParticleSystem(starsParticleSystem)
        scene.rootNode.addChildNode(planetNode)
        
        sceneView.scene = scene
        sceneView.backgroundColor = UIColor.black
        sceneView.allowsCameraControl = true
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.cameraControlConfiguration.autoSwitchToFreeCamera = true
        sceneView.cameraControlConfiguration.allowsTranslation = true
        sceneView.cameraControlConfiguration.rotationSensitivity = 0.4
        
        
        playButton.layer.shadowColor = UIColor.white.cgColor
        playButton.layer.shadowOpacity = 1
        playButton.layer.shadowOffset = .zero
        playButton.layer.shadowRadius = 1
        playButton.layer.cornerRadius = 12
        playButton.layer.borderColor = UIColor.black.cgColor
        playButton.layer.borderWidth = 0.8
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "8K HDR", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = UIColor.green

    }
    

}
