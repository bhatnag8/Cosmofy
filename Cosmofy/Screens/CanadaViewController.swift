//  ========================================
//  CanadaViewController.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 9/9/23.
//  Abstract: A really funny view
//  ========================================


import UIKit

class CanadaViewController: UIViewController {
    

    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var view1: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        greetingLabel.animate(newText: greetingLabel.text ?? "Greetings from Swift! 🇨🇦🍁🏒🏔️🐻", characterDelay: 0.05)
        
        let seconds = 1.5
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay here
            self.messageLabel.animate(newText: "We've harnessed the power of AI for all your space related quiries.", characterDelay: 0.02)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            // Put your code which should be executed with a delay here
            self.statusLabel.animate(newText: "Status: Online", characterDelay: 0.05)
        }
        
        view1.layer.cornerRadius = 16
        
        
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

