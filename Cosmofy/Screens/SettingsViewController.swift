//  ========================================
//  SettingsViewController.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 7/11/23.
//  Abstract: A view controller for users changing the settings.
//  ========================================

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var signOutButton: UIButton!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        signOutButton.layer.cornerRadius = signOutButton.frame.height / 2
        

    }
 
    @IBAction func signOutButtonPressed() {
        
        KeychainItem.deleteUserIdentifierFromKeychain()
        
        DispatchQueue.main.async {
            self.showLoginViewController()
        }
    }
    
}
