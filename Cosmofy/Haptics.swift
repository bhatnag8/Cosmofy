//  ========================================
//  Haptics.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 7/13/23.
//  ========================================

import Foundation
import UIKit

final class Haptics {
    
    static let shared = Haptics()
    
    private init() {
        
    }
    
    public func selectionVibrate() {
        DispatchQueue.main.async {
//            print("Haptics for selectionVibrate")
            let selectionFG = UISelectionFeedbackGenerator()
            selectionFG.prepare()
            selectionFG.selectionChanged()
        }
    }
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
//            print("Haptics for \(type)")
            let notificationFG = UINotificationFeedbackGenerator()
            notificationFG.prepare()
            notificationFG.notificationOccurred(type)
        }
    }
    
    public func impact(for style: UIImpactFeedbackGenerator.FeedbackStyle) {
        DispatchQueue.main.async {
            let date = Date()
            print("Haptics for \(style) \(date.timeIntervalSince1970)")
            let impactFG = UIImpactFeedbackGenerator(style: style)
            impactFG.prepare()
            impactFG.impactOccurred()
        }
    }
}
