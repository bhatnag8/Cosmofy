//  ========================================
//  LoginViewController.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 7/4/23.
//  Abstract: A view controller for registering an account onto the back-end.
//  ========================================

import UIKit
import CloudKit
import Foundation
import AuthenticationServices

// MARK: - UIViewController
class LoginViewController: UIViewController {

    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var loginProviderStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Logo.layer.cornerRadius = 12
        UserDefaults.standard.set("Hello", forKey: "s1")

        setupProviderLoginView()
    }

    func setupProviderLoginView() {
        let authorizationButton = ASAuthorizationAppleIDButton(authorizationButtonType: .continue, authorizationButtonStyle: .black)
        authorizationButton.cornerRadius = authorizationButton.bounds.height / 2
        authorizationButton.layer.cornerCurve = .continuous
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.loginProviderStackView.addArrangedSubview(authorizationButton)
    }
    
    // currently disabled [not called anywhere]
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // Performing Apple ID Request
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

}

// MARK: - ASAuthorizationControllerDelegate
extension LoginViewController: ASAuthorizationControllerDelegate {
    
    // Did Complete Authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        let privateDatabase = CKContainer(identifier: "iCloud.com.snape447.Cosmofy.users").privateCloudDatabase
        
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
                print("entering")
                print(userIdentifier)
                print(appleIDCredential.fullName?.givenName)
                print(appleIDCredential.fullName?.familyName)
                print(appleIDCredential.email)
            
            if let firstname = appleIDCredential.fullName?.givenName,
               let lastname = appleIDCredential.fullName?.familyName,
               let email = appleIDCredential.email
            {
                print("if successful")
                let record = CKRecord(recordType: "UserInfo", recordID: CKRecord.ID(recordName: userIdentifier))
                
                record["firstName"] = firstname as String
                record["lastName"] = lastname as String
                record["emailAddress"] = email as String
                
                privateDatabase.save(record) { (_, _) in
                    print("creating record")
                    UserDefaults.standard.set(record.recordID.recordName, forKey: "userProfileID")
                }
            
                
            } else {
                print("fetching record")
                privateDatabase.fetch(withRecordID: CKRecord.ID(recordName: userIdentifier)) {
                    (record, error) in
                    if record != nil {
                        UserDefaults.standard.set(userIdentifier, forKey: "userProfileID")
                    }
                    else {
                        print("this is happeing")
                    }
                }
            }
            
            // Store the 'userIdentifier' in the keychain.
            self.saveUserInKeychain(userIdentifier)
                                
            let final_firstName = appleIDCredential.fullName?.givenName
            let final_lastName = appleIDCredential.fullName?.familyName
            let final_email = appleIDCredential.email
                
            self.showResultViewController(firstName: final_firstName, lastName: final_lastName, email: final_email)
   
        
        case let passwordCredential as ASPasswordCredential:
        
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            // Show the password credential as an alert.
            DispatchQueue.main.async {
                self.showPasswordCredentialAlert(username: username, password: password)
            }
            
        default:
            break
        }
    }
    
    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: "com.snape447.Cosmofy", account: "userIdentifier").saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }
    
    private func showResultViewController(firstName: String?, lastName: String?, email: String?) {
        
        // storing the user credentials [not password] into the
        DispatchQueue.main.async {
            if let givenName = firstName {
                UserDefaults.standard.set(givenName, forKey: "s1")
            }
            if let familyName = lastName {
                UserDefaults.standard.set(familyName, forKey: "s2")
            }
            if let email2 = email {
                UserDefaults.standard.set(email2, forKey: "s3")
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Keychain Credential Received",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// - Tag: did_complete_error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}
// MARK: - ASAuthorizationControllerPresentationContextProviding
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}


// MARK: - extension
extension UIViewController {
    
    func showLoginViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginViewController") as? LoginViewController {
            loginViewController.modalPresentationStyle = .fullScreen
            loginViewController.isModalInPresentation = true
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
}
