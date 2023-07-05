//  ========================================
//  TestViewController2.swift
//  Spacefy
//  4th Edition
//  Created by Arryan Bhatnagar on 7/4/23.
//  ========================================

import UIKit

class TestViewController2: UIViewController {

    @IBOutlet weak var SignIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        
        SignIn.layer.cornerRadius = SignIn.bounds.height / 2
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
