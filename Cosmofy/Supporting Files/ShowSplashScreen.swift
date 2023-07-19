//  ========================================
//  ShowSplashScreen.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 6/11/23.
//  ========================================

import UIKit

class ShowSplashScreen: UIViewController {

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perform(#selector(showController), with: AnyObject.self, afterDelay: 3)
    }
    
    @objc func showController() {
        performSegue(withIdentifier: "showSplashScreen", sender: self)
    }

}
