//
//  Haptics.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 7/13/23.
//

import Foundation
import UIKit

final class Haptics {
    
    static let shared = Haptics()
    
    private init() {
        
    }
    
    public func selectionVibrate() {
        DispatchQueue.main.async {
            let selectionFG = UISelectionFeedbackGenerator()
            selectionFG.prepare()
            selectionFG.selectionChanged()
        }
    }
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let notificationFG = UINotificationFeedbackGenerator()
            notificationFG.prepare()
            notificationFG.notificationOccurred(type)
        }
    }
    
    public func impact(for style: UIImpactFeedbackGenerator.FeedbackStyle) {
        DispatchQueue.main.async {
            let impactFG = UIImpactFeedbackGenerator(style)
            impactFG.prepare()
            impactFG.impactOccurred()
        }
    }
}
