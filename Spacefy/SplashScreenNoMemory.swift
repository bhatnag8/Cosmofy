//  ========================================
//  SplashScreenNoMemory.swift
//  Spacefy
//  4th Edition
//  Created by Arryan Bhatnagar on 12/12/22.
//  ========================================

import UIKit

class SplashScreenNoMemory: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        perform(#selector(self.showNavController), with: nil, afterDelay: 0.75)
    }
    
    @objc func showNavController() {
        performSegue(withIdentifier: "showMemory", sender: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

}
