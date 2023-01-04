//  ========================================
//  MercuryViewController.swift
//  Spacefy
//  4th Edition
//  Created by Arryan Bhatnagar on 12/16/22.
//  ========================================

import UIKit

class MercuryViewController: UIViewController {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var status1: UIImageView!
    @IBOutlet weak var status2: UIImageView!
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidLayoutSubviews() {
        status1.layer.cornerRadius = status1.frame.height / 2
        
        status2.layer.cornerRadius = status2.frame.height / 2
        
        view1.layer.shadowColor = UIColor.white.cgColor
        view1.layer.shadowOpacity = 1
        view1.layer.shadowOffset = .zero
        view1.layer.shadowRadius = 1
        view1.layer.cornerRadius = 24
        view1.layer.borderColor = UIColor.black.cgColor
        view1.layer.borderWidth = 1
        
        view2.layer.shadowColor = UIColor.white.cgColor
        view2.layer.shadowOpacity = 1
        view2.layer.shadowOffset = .zero
        view2.layer.shadowRadius = 1
        view2.layer.cornerRadius = 24
        view2.layer.borderColor = UIColor.black.cgColor
        view2.layer.borderWidth = 1
        
        view3.layer.shadowColor = UIColor.white.cgColor
        view3.layer.shadowOpacity = 1
        view3.layer.shadowOffset = .zero
        view3.layer.shadowRadius = 1
        view3.layer.cornerRadius = 24
        view3.layer.borderColor = UIColor.black.cgColor
        view3.layer.borderWidth = 1
        
        button1.layer.shadowColor = UIColor.white.cgColor
        button1.layer.shadowOpacity = 1
        button1.layer.shadowOffset = .zero
        button1.layer.shadowRadius = 1
        button1.layer.cornerRadius = button1.frame.height / 2
        button1.layer.borderColor = UIColor.black.cgColor
        button1.layer.borderWidth = 1
        
        button2.layer.shadowColor = UIColor.white.cgColor
        button2.layer.shadowOpacity = 1
        button2.layer.shadowOffset = .zero
        button2.layer.shadowRadius = 1
        button2.layer.cornerRadius = button2.frame.height / 2
        button2.layer.borderColor = UIColor.black.cgColor
        button2.layer.borderWidth = 1
    }
}

