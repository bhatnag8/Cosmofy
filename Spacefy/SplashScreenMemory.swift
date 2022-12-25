//  ========================================
//  SplashScreenMemory.swift
//  Spacefy
//  4th Edition
//  Created by Arryan Bhatnagar on 12/23/22.
//  ========================================

import UIKit

class SplashScreenMemory: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.isUserInteractionEnabled = false
        perform(#selector(self.showNavController), with: nil, afterDelay: 1.5)
    }
    
    @objc func showNavController() {
        performSegue(withIdentifier: "showSplashScreen", sender: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }


}
