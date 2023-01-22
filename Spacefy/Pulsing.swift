//
//  Pulsing.swift
//  Spacefy
//
//  Created by Arryan Bhatnagar on 1/21/23.
//

import UIKit

class Pulsing: CALayer {
    
    var animationGroup = CAAnimationGroup()
    var scale : Float = 0
    var nextPulse : TimeInterval = 0
    var animationDuration : TimeInterval = 1.5
    var radius : CGFloat = 120
    var numPulses : Float = Float.infinity
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (numPulses:Float = Float.infinity, radius:CGFloat, position:CGPoint) {
            super.init()
            
            self.backgroundColor = UIColor.black.cgColor
            self.contentsScale = UIScreen.main.scale
            self.opacity = 0
            self.radius = radius
            self.numPulses = numPulses
            self.position = position
            
            self.bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
            self.cornerRadius = radius
            
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                self.setupAnimationGroup()
                
                DispatchQueue.main.async {
                     self.add(self.animationGroup, forKey: "pulse")
                }
            }

            
            
        }
        
        
        func createScaleAnimation () -> CABasicAnimation {
            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
            scaleAnimation.fromValue = NSNumber(value: scale)
            scaleAnimation.toValue = NSNumber(value: 1)
            scaleAnimation.duration = animationDuration
            
            return scaleAnimation
        }
        
        func createOpacityAnimation() -> CAKeyframeAnimation {
            
            let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
            opacityAnimation.duration = animationDuration
            opacityAnimation.values = [0.4, 0.8, 0]
            opacityAnimation.keyTimes = [0, 0.2, 1]
        
            
            return opacityAnimation
        }
        
        func setupAnimationGroup() {
            self.animationGroup = CAAnimationGroup()
            self.animationGroup.duration = animationDuration + nextPulse
            self.animationGroup.repeatCount = numPulses
            
            let defaultCurve = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
            self.animationGroup.timingFunction = defaultCurve
            
            self.animationGroup.animations = [createScaleAnimation(), createOpacityAnimation()]
            
            
        }
    
}
