//
//  NewsViewController.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 12/7/23.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var spaceImage: RoundedTopCornersImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsView.layer.cornerRadius = 24
        
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

class RoundedTopCornersImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Create a mask layer with rounded top corners
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 24, height: 24)
        ).cgPath
        
        // Apply the mask to the image view's layer
        layer.mask = maskLayer
    }
}
