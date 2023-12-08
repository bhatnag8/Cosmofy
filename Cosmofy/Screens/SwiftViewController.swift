//  ========================================
//  SwiftViewController.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 9/9/23.
//  Abstract: A really funny view
//  ========================================


import UIKit
import SwiftUI

class SwiftViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!

    @IBOutlet weak var clearView: UIView!
    
    @IBOutlet weak var backView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.bringSubviewToFront(view1)
        mainView.bringSubviewToFront(view2)
        mainView.bringSubviewToFront(clearView)

        view1.alpha = 0.0
        view2.alpha = 0.0
        view3.alpha = 0.0
        
        UIView.animate(withDuration: 1.0) {
            self.view1.alpha = 1.0
        }
        
        self.greetingLabel.animate(newText: "Greetings from Swift! 🌌 🚀 🌠 🏔️ 🌟", characterDelay: 0.06)
         
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            self.messageLabel.animate(newText: "I'm powered by OpenAI, providing you with in-depth knowledge and insights about space like never before.", characterDelay: 0.025)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.25) {
            self.statusLabel.animate(newText: "Status: Online (Beta)", characterDelay: 0.025)
            UIView.animate(withDuration: 1.0) {
                self.view2.alpha = 1.0
            }
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.75) {
            self.stateLabel.animate(newText: "Please note that Swift's responses haven't been fully trained as it's still a beta feature.", characterDelay: 0.025)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            UIView.animate(withDuration: 1.0) {
                self.view3.alpha = 1.0
            }
        }
        
        view1.layer.cornerRadius = 32
        view2.layer.cornerRadius = 32
        view3.layer.cornerRadius = 32
                
        view3.layer.borderColor = UIColor(named: "SOUR")?.cgColor
        view3.layer.borderWidth = 2
    }
    @IBAction func fade(_ sender: Any) {
        Haptics.shared.vibrate(for: .success)
        UIView.animate(withDuration: 0.5) {
            self.view3.alpha = 0
            self.view2.alpha = 0
            self.view1.alpha = 0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let cv = UIHostingController(rootView: ContentView())
            self.addChild(cv)
            cv.view.frame = self.backView.bounds
            self.mainView.alpha = 0
    
            self.backView.addSubview(cv.view)
            self.mainView.bringSubviewToFront(self.backView)
            UIView.animate(withDuration: 0.5) {
                self.mainView.alpha = 1
            }
        }
    }
}

extension UILabel {
    func animate(newText: String, characterDelay: TimeInterval) {
        DispatchQueue.main.async {
            self.text = ""
            for (index, character) in newText.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) {
                    self.text?.append(character)
                }
            }
        }
    }
}

