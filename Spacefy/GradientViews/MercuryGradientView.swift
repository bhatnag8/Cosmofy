//  ========================================
//  MercuryGradientView.swift
//  Spacefy
//  4th Edition
//  Created by Arryan Bhatnagar on 1/4/23.
//  ========================================

import UIKit

class MercuryGradientView : UIView {
    
    var color1 = UIColor(named: "GradientTop") { didSet { updateColors() }}
    var color2 =  UIColor(named: "GradientMercury") { didSet { updateColors() }}
    var diagonalMode: Bool =  true { didSet { updatePoints() }}
    var myLayer = CAGradientLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateColors()
        updatePoints()
        myLayer.frame = self.bounds
        self.layer.insertSublayer(myLayer, at: 0)
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }

    
    func updatePoints() {
        myLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
        myLayer.endPoint = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
    }
    
    func updateColors() {
        myLayer.colors = [color1?.cgColor as Any, color2?.cgColor as Any]
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateColors()
    }

}


