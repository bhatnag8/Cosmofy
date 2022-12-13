//  ========================================
//  PlanetsViewController.swift
//  Spacefy
//  4th Edition
//  Created by Arryan Bhatnagar on 12/11/22.
//  ========================================

import UIKit

class PlanetsViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view1.layer.cornerRadius = 24
        view2.layer.cornerRadius = 24
        
        view1.layer.borderColor = UIColor.gray.cgColor
        view2.layer.borderColor = UIColor.gray.cgColor
        
        view1.layer.borderWidth = 1
        view2.layer.borderWidth = 1
        
        view1.layer.shadowColor = UIColor.black.cgColor
        view1.layer.shadowOpacity = 1
        view1.layer.shadowOffset = .zero
        view1.layer.shadowRadius = 1
        
        view2.layer.shadowColor = UIColor.black.cgColor
        view2.layer.shadowOpacity = 1
        view2.layer.shadowOffset = .zero
        view2.layer.shadowRadius = 1
    }
}
