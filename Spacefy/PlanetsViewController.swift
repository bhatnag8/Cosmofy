//  ========================================
//  PlanetsViewController.swift
//  Spacefy
//  4th Edition
//  Created by Arryan Bhatnagar on 12/11/22.
//  ========================================

import UIKit

class PlanetsViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var innerView1: UIView!
    @IBOutlet weak var bottomView1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var innerView2: UIView!
    @IBOutlet weak var bottomView2: UIView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view1.layer.shadowColor = UIColor.black.cgColor
        view1.layer.shadowOpacity = 1
        view1.layer.shadowOffset = .zero
        view1.layer.shadowRadius = 1
        view1.layer.cornerRadius = 24
        view1.layer.borderColor = UIColor.gray.cgColor
        view1.layer.borderWidth = 1
        
        view2.layer.shadowColor = UIColor.black.cgColor
        view2.layer.shadowOpacity = 1
        view2.layer.shadowOffset = .zero
        view2.layer.shadowRadius = 1
        view2.layer.cornerRadius = 24
        view2.layer.borderColor = UIColor.gray.cgColor
        view2.layer.borderWidth = 1
        
        innerView1.layer.cornerRadius = 24
        bottomView1.layer.cornerRadius = 24
        
        innerView2.layer.cornerRadius = 24
        bottomView2.layer.cornerRadius = 24
    }
    
    override func viewDidAppear(_ animated: Bool) {
        button1.layer.cornerRadius = button1.bounds.height / 2
        button2.layer.cornerRadius = button2.bounds.height / 2
        button3.layer.cornerRadius = button2.bounds.height / 2
        button4.layer.cornerRadius = button3.bounds.height / 2
        button5.layer.cornerRadius = button4.bounds.height / 2
        button6.layer.cornerRadius = button5.bounds.height / 2
        button7.layer.cornerRadius = button6.bounds.height / 2
        button8.layer.cornerRadius = button7.bounds.height / 2
    }

}
