//  ========================================
//  Venus3D.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 8/10/23.
//  ========================================

import UIKit
import SceneKit

class Venus3D: UIViewController {
    
    @IBOutlet weak var sceneView: SCNView!
    let scene = SCNScene()
    let node = SCNNode()
    let camera = SCNCamera()
    let starsParticleSystem = SCNParticleSystem(named: "StarsParticleSystem.scnp", inDirectory: nil)!
    
    var planetNode = PlanetNode(radius: 1.1, planet: "venus", rotation: 6)
    var pause = false
    
    @IBOutlet weak var playButton: UIButton!

    @IBOutlet weak var axisSwitch: UISwitch!
    
    @IBAction func playButton(_ sender: Any) {
        Haptics.shared.impact(for: .soft)
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            Haptics.shared.impact(for: .soft)
        }
    }
    
    @IBOutlet weak var speed1: UIButton!
    @IBOutlet weak var speed2: UIButton!
    @IBOutlet weak var speed3: UIButton!
    
    @IBAction func speed1(_ sender: Any) {
        Haptics.shared.impact(for: .medium)
        planetNode.stopRotation()
        planetNode.setRotation(r: 6)
        planetNode.startRotation()
        playButton.setImage(UIImage(systemName: "pause"), for: .normal)
        speed1.layer.borderColor = UIColor.tintColor.cgColor
        speed2.layer.borderColor = UIColor.black.cgColor
        speed3.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func speed2(_ sender: Any) {
        Haptics.shared.impact(for: .medium)
        planetNode.stopRotation()
        planetNode.setRotation(r: 3)
        planetNode.startRotation()
        playButton.setImage(UIImage(systemName: "pause"), for: .normal)
        speed1.layer.borderColor = UIColor.black.cgColor
        speed2.layer.borderColor = UIColor.tintColor.cgColor
        speed3.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func speed3(_ sender: Any) {
        Haptics.shared.impact(for: .medium)
        planetNode.stopRotation()
        planetNode.setRotation(r: 1.5)
        planetNode.startRotation()
        playButton.setImage(UIImage(systemName: "pause"), for: .normal)
        speed1.layer.borderColor = UIColor.black.cgColor
        speed2.layer.borderColor = UIColor.black.cgColor
        speed3.layer.borderColor = UIColor.tintColor.cgColor
    }
    
    let tilt = -177.36
    let tiltNode = SCNNode()
    
    let poleNode = SCNNode()
    let pole = SCNCylinder(radius: 0.01, height: 3.2)
    let poleMaterial = SCNMaterial()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tiltNode.eulerAngles = SCNVector3(x: 0, y: 0, z: Float(tilt * (.pi/180.0)))
        tiltNode.addChildNode(planetNode)
        
        poleNode.geometry = pole
        
        poleMaterial.diffuse.contents = UIColor.white
        
        pole.firstMaterial = poleMaterial
        
        camera.wantsHDR = true
        camera.wantsExposureAdaptation = false
        
        node.camera = camera
        node.position = SCNVector3(0, 0, 5)
        
        scene.rootNode.addChildNode(node)
        scene.rootNode.addParticleSystem(starsParticleSystem)
        scene.rootNode.addChildNode(tiltNode)
        
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
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "More...", style: .plain, target: self, action: nil)
//        navigationItem.rightBarButtonItem?.tintColor = UIColor.systemBlue

        speed1.layer.shadowColor = UIColor.white.cgColor
        speed1.layer.shadowOpacity = 1
        speed1.layer.shadowOffset = .zero
        speed1.layer.shadowRadius = 1
        speed1.layer.cornerRadius = speed1.frame.height / 2
        speed1.layer.borderColor = UIColor.tintColor.cgColor
        speed1.layer.borderWidth = 0.8
        
        speed2.layer.shadowColor = UIColor.white.cgColor
        speed2.layer.shadowOpacity = 1
        speed2.layer.shadowOffset = .zero
        speed2.layer.shadowRadius = 1
        speed2.layer.cornerRadius = speed2.frame.height / 2
        speed2.layer.borderColor = UIColor.black.cgColor
        speed2.layer.borderWidth = 0.8
        
        speed3.layer.shadowColor = UIColor.white.cgColor
        speed3.layer.shadowOpacity = 1
        speed3.layer.shadowOffset = .zero
        speed3.layer.shadowRadius = 1
        speed3.layer.cornerRadius = speed3.frame.height / 2
        speed3.layer.borderColor = UIColor.black.cgColor
        speed3.layer.borderWidth = 0.8

    }
    
    @IBAction func switchDidChange(_ sender: UISwitch) {
        Haptics.shared.impact(for: .medium)
        if sender.isOn {
            planetNode.addChildNode(poleNode)
        } else {
            poleNode.removeFromParentNode()
        }
    }
}
