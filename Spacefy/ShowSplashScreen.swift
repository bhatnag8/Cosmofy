//  ========================================
//  ShowSplashScreen.swift
//  Spacefy
//  4th Edition
//  Created by Arryan Bhatnagar on 6/11/23.
//  ========================================

import UIKit

class ShowSplashScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        perform(#selector(showController), with: AnyObject.self, afterDelay: 3)
    }
    
    @objc func showController() {
        performSegue(withIdentifier: "showSplashScreen", sender: self)
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
