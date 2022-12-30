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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = SCNScene()
        let node = SCNNode()
        let camera = SCNCamera()
        let starsParticleSystem = SCNParticleSystem(named: "StarsParticleSystem.scnp", inDirectory: nil)!
        
        node.camera = camera
        scene.rootNode.addChildNode(node)
        scene.rootNode.addParticleSystem(starsParticleSystem)
        sceneView.scene = scene
        sceneView.backgroundColor = UIColor.black
        sceneView.allowsCameraControl = true
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
