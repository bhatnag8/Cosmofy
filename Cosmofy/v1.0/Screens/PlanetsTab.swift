//  ========================================
//  PlanetsTab.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 2/19/24.
//  Abstract: A really funny view
//  ========================================


import UIKit
import SwiftUI

class PlanetsTab: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var backView: UIView!
    
    var childView: UIHostingController<PlanetSwiftUI>?
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        childView = UIHostingController(rootView: PlanetSwiftUI())
        addChild(childView!)
        childView!.view.frame = backView.bounds
        backView.addSubview(childView!.view)
        mainView.bringSubviewToFront(backView)

        self.tabBarController?.tabBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    // MARK: - viewWillDisappear
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)

            // Show the tab bar when navigating away from this view
            self.tabBarController?.tabBar.isHidden = false
        }

}

