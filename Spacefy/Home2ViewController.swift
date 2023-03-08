//
//  Home2ViewController.swift
//  Spacefy
//
//  Created by Arryan Bhatnagar on 3/7/23.
//

import UIKit
import SwiftUI

class Home2ViewController: UIViewController {

    @IBOutlet weak var myview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let child  = UIHostingController(rootView: SwiftUIView())
        addChild(child)
        child.view.frame = myview.bounds
        myview.addSubview(child.view)
        // Do any additional setup after loading the view.
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
