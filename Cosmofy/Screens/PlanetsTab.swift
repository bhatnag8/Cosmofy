//  ========================================
//  PlanetsTab.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 2/19/24.
//  Abstract: A really funny view
//  ========================================


import UIKit
import SwiftUI

class PlanetsTab: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var backView: UIView!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        let childView = UIHostingController(rootView: Planet())
        addChild(childView)
        childView.view.frame = backView.bounds
        backView.addSubview(childView.view)
        mainView.bringSubviewToFront(backView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Update the frame of the SwiftUI view to match the container's bounds
        if let childView = children.first {
            childView.view.frame = backView.bounds
        }
    }
}
