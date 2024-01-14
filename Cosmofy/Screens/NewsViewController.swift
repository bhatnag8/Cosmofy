//
//  NewsViewController.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 12/7/23.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var spaceImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsView.layer.cornerRadius = 24
        spaceImage.layer.cornerRadius = 24
        spaceImage.layer.masksToBounds = true
        
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


