//
//  SwiftViewController.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 10/24/23.
//

import UIKit
import SwiftUI

class SwiftViewController: UIViewController {
    
    @IBOutlet weak var container : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let childView = UIHostingController(rootView: ContentView())
        addChild(childView)
        childView.view.frame = container.bounds
        container.addSubview(childView.view)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            
        // Update the frame of the SwiftUI view to match the container's bounds
        if let childView = children.first {
            childView.view.frame = container.bounds
        }
    }

}
