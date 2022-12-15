//  ========================================
//  ShowSplashScreen.swift
//  Spacefy
//  4th Edition
//  Created by Arryan Bhatnagar on 12/12/22.
//  ========================================

import UIKit

class ShowSplashScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        perform(#selector(self.showNavController), with: nil, afterDelay: 1)
    }
    
    @objc func showNavController() {
        performSegue(withIdentifier: "showSplashScreen", sender: self)
    }

}
