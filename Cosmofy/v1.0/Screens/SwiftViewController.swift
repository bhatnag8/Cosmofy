//  ========================================
//  SwiftViewController.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 9/9/23.
//  Abstract: A really funny view
//  ========================================


import UIKit
import SwiftUI

class SwiftViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var backView: UIView!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        let childView = UIHostingController(rootView: SwiftView())
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
