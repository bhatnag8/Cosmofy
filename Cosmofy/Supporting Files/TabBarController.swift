//  ========================================
//  TabBarController.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 8/12/23.
//  ========================================

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
    }
    

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        Haptics.shared.impact(for: .rigid)
    }

}
