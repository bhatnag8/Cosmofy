//  ========================================
//  PlanetsViewController.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 12/11/22.
//  ========================================

import UIKit
import SwiftUI

class PlanetsViewController: UIViewController {
    
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var stack: UIStackView!
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
    
    
    @IBAction func buttons_tapped(_ sender: Any) {
        Haptics.shared.vibrate(for: .success)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let childView = UIHostingController(rootView: GradientView())
        addChild(childView)
        childView.view.frame = mainView.bounds
        mainView.addSubview(childView.view)
        mainView.bringSubviewToFront(stack)
//        mainView.bringSubviewToFront(view2)
        
        view1.layer.shadowColor = UIColor.black.cgColor
        view1.layer.shadowOpacity = 1
        view1.layer.shadowOffset = .zero
        view1.layer.shadowRadius = 0.5
        view1.layer.cornerRadius = 24
        view1.layer.borderColor = UIColor.black.cgColor
        view1.layer.borderWidth = 0.25
        
        view2.layer.shadowColor = UIColor.black.cgColor
        view2.layer.shadowOpacity = 1
        view2.layer.shadowOffset = .zero
        view2.layer.shadowRadius = 0.5
        view2.layer.cornerRadius = 24
        view2.layer.borderColor = UIColor.black.cgColor
        view2.layer.borderWidth = 0.25

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            
        // Update the frame of the SwiftUI view to match the container's bounds
        if let childView = children.first {
            childView.view.frame = mainView.bounds
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        Haptics.shared.impact(for: .rigid)
        
        innerView1.layer.shadowColor = UIColor.black.cgColor
        innerView1.layer.shadowOpacity = 1
        innerView1.layer.shadowOffset = .zero
        innerView1.layer.shadowRadius = 0.5
        innerView1.layer.cornerRadius = 24
        innerView1.layer.borderColor = UIColor.black.cgColor
        innerView1.layer.borderWidth = 0.25
        
        innerView2.layer.shadowColor = UIColor.black.cgColor
        innerView2.layer.shadowOpacity = 1
        innerView2.layer.shadowOffset = .zero
        innerView2.layer.shadowRadius = 0.5
        innerView2.layer.cornerRadius = 24
        innerView2.layer.borderColor = UIColor.black.cgColor
        innerView2.layer.borderWidth = 0.25
        
        bottomView1.layer.shadowColor = UIColor.black.cgColor
        bottomView1.layer.shadowOpacity = 1
        bottomView1.layer.shadowOffset = .zero
        bottomView1.layer.shadowRadius = 0.5
        bottomView1.layer.cornerRadius = 24
        bottomView1.layer.borderColor = UIColor.black.cgColor
        bottomView1.layer.borderWidth = 0.25
        
        bottomView2.layer.shadowColor = UIColor.black.cgColor
        bottomView2.layer.shadowOpacity = 1
        bottomView2.layer.shadowOffset = .zero
        bottomView2.layer.shadowRadius = 0.5
        bottomView2.layer.cornerRadius = 24
        bottomView2.layer.borderColor = UIColor.black.cgColor
        bottomView2.layer.borderWidth = 0.25
        
        let buttons = [
            button1, button2, button3,
            button4, button5, button6,
            button7, button8
        ]
        
        for index in 0...7 {
            buttons[index]?.layer.shadowColor = UIColor.black.cgColor
            buttons[index]?.layer.shadowOpacity = 1
            buttons[index]?.layer.shadowOffset = .zero
            buttons[index]?.layer.shadowRadius = 0.5
            buttons[index]?.layer.cornerRadius = (buttons[index]?.bounds.height)! / 2
            buttons[index]?.layer.borderColor = UIColor.black.cgColor
            buttons[index]?.layer.borderWidth = 0.25
        }
    }
}
