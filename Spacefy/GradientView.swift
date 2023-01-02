//  ========================================
//  GradientView.swift
//  Spacefy
//  4th Edition
//  Created by Arryan Bhatnagar on 1/2/23.
//  ========================================

import UIKit

@IBDesignable
class GradientView : UIView {
    
    @IBInspectable var color1: UIColor = .white { didSet { updateColors() }}
    @IBInspectable var color2: UIColor = .white { didSet { updateColors() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    
    
    override public class var layerClass: AnyClass { CAGradientLayer.self }
    var myLayer: CAGradientLayer { layer as! CAGradientLayer }

    func updatePoints() {
        myLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
        myLayer.endPoint = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
    }
    
    func updateColors() {
        myLayer.colors = [color1.cgColor, color2.cgColor]
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateColors()
    }

    
}

