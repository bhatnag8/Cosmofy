//
//  TestViewController.swift
//  Spacefy
//
//  Created by Arryan Bhatnagar on 6/30/23.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var goodLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
            case 4..<11 : goodLabel.text = "Good Morning"
            case 12..<16 : goodLabel.text = "Good Afternoon"
            case 17..<24 : goodLabel.text = "Good Evening"
            default: goodLabel.text = "Hello"
        }
        
        

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
