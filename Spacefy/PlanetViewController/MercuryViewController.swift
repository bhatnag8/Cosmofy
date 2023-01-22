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
    
    @IBOutlet weak var coreLabel1: UILabel!
    @IBOutlet weak var coreLabel2: UILabel!
    
    var timer : Timer?
    var timer2 : Timer?
    var currentLabel = 1
    
    @objc func addPulse () {
        let newTap1 = view1.convert(button1.center, to: view)
        let newTap2 = view1.convert(button2.center, to: view)
        let newTap3 = view1.convert(status1.center, to: view)
        let newTap4 = view1.convert(status2.center, to: view)
        
        let pulse1 = Pulse(num: 1, rad: 40, pos: newTap1, duration: 1)
        let pulse2 = Pulse(num: 1, rad: 40, pos: newTap2, duration: 1)
        let pulse3 = Pulse(num: 1, rad: 12, pos: newTap3, duration: 1)
        let pulse4 = Pulse(num: 1, rad: 12, pos: newTap4, duration: 1)
        
        pulse1.backgroundColor = UIColor(named: "colorMercury")?.cgColor
        pulse2.backgroundColor = UIColor(named: "colorMercury")?.cgColor
        pulse3.backgroundColor = UIColor.green.cgColor
        pulse4.backgroundColor = UIColor.red.cgColor
        
        self.view.layer.insertSublayer(pulse1, below: button1.layer)
        self.view.layer.insertSublayer(pulse2, below: button2.layer)
        self.view.layer.insertSublayer(pulse3, below: status1.layer)
        self.view.layer.insertSublayer(pulse4, below: status2.layer)
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
    
    override func viewWillAppear(_ animated: Bool) {
        startTimer(time: 7.0)
        timer2 = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(self.addPulse), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
        timer2?.invalidate()
    }
    
    func startTimer(time: Double) {
        timer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc func moveToNextIndex() {
        
        if (currentLabel == 0) {
            
            UIView.transition(with: coreLabel1,
                          duration: 0.25,
                           options: .transitionCrossDissolve,
                        animations: { [weak self] in
                self?.coreLabel1.text = "Mercury is 2.6x"
                     }, completion: nil)
            
            UIView.transition(with: coreLabel2,
                          duration: 0.25,
                           options: .transitionCrossDissolve,
                        animations: { [weak self] in
                self?.coreLabel2.text = "smaller than Earth"
                     }, completion: nil)
            currentLabel = currentLabel + 1
        } else if (currentLabel == 1) {
            
            
            UIView.transition(with: coreLabel1,
                          duration: 0.25,
                              options: .transitionCrossDissolve,
                        animations: { [weak self] in
                self?.coreLabel1.text = "Mercury's core is"
                     }, completion: nil)
            
            UIView.transition(with: coreLabel2,
                          duration: 0.25,
                              options: .transitionCrossDissolve,
                        animations: { [weak self] in
                self?.coreLabel2.text = "85% of the radius"
                     }, completion: nil)
            currentLabel = currentLabel + 1
        } else if (currentLabel == 2) {
            currentLabel = 0
            
            UIView.transition(with: coreLabel1,
                          duration: 0.25,
                           options: .transitionCrossDissolve,
                        animations: { [weak self] in
                self?.coreLabel1.text = "Solid Inner Core"
                     }, completion: nil)
            
            UIView.transition(with: coreLabel2,
                          duration: 0.25,
                           options: .transitionCrossDissolve,
                        animations: { [weak self] in
                self?.coreLabel2.text = "Iron Sulfide Outer Core"
                     }, completion: nil)
            
        }
        
    }
}

