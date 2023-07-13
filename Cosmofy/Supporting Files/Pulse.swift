//  ========================================
//  Pulse.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 1/21/23.
//  ========================================

import UIKit

class Pulse: CALayer {
    
    var animationGroup = CAAnimationGroup()
    var scale : Float = 0
    var nextPulse : TimeInterval = 0
    var animationDuration : TimeInterval = 1.5
    var radius : CGFloat = 0
    var numPulses : Float = Float.infinity
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder c : NSCoder) {
        super.init(coder: c)
    }
    
    init (num : Float = Float.infinity, rad : CGFloat, pos : CGPoint, duration : TimeInterval) {
            super.init()
            
            self.backgroundColor = UIColor.black.cgColor
            self.contentsScale = UIScreen.main.scale
            self.opacity = 0
            self.radius = rad
            self.position = pos
            self.numPulses = num
            self.bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
            self.cornerRadius = radius
            self.animationDuration = duration
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                self.animationGroup = CAAnimationGroup()
                self.animationGroup.duration = self.animationDuration + self.nextPulse
                self.animationGroup.repeatCount = self.numPulses
                
                let curve = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
                self.animationGroup.timingFunction = curve
                
                self.animationGroup.animations = [
                    self.createScaleAnimation(), self.createOpacityAnimation()]
                
                DispatchQueue.main.async {
                     self.add(self.animationGroup, forKey: "pulse")
                }
            }
        }
  
        func createScaleAnimation () -> CABasicAnimation {
            let sa = CABasicAnimation(keyPath: "transform.scale.xy")
            sa.fromValue = NSNumber(value: scale)
            sa.toValue = NSNumber(value: 1)
            sa.duration = animationDuration
            return sa
        }
        
        func createOpacityAnimation() -> CAKeyframeAnimation {
            let oa = CAKeyframeAnimation(keyPath: "opacity")
            oa.duration = animationDuration
            oa.values = [0.85, 0.45, 0.35, 0.1]
            oa.keyTimes = [0, 0.8, 0.9, 1]
            return oa
        }
}
