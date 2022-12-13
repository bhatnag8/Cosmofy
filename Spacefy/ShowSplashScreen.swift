//
//  ShowSplashScreen.swift
//  Spacefy
//
//  Created by Arryan Bhatnagar on 12/12/22.
//

import UIKit

class ShowSplashScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        perform(Selector("showNavController"), with: nil, afterDelay: 3)
        // Do any additional setup after loading the view.
    }
    
    @objc func showNavController() {
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
