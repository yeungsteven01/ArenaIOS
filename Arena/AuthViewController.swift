//
//  AuthViewController.swift
//  Arena
//
//  Created by Aram Baali on 11/10/22.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AuthViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var passwordConfirmLabel: UILabel!
    @IBOutlet weak var passwordConfirmField: UITextField!
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var alternateActionButton: UIButton!
    
    let kUserLoggedInID = "loggedInID"
    let defaults = UserDefaults.standard
    
    var actionItem = "register"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set button to register
        self.actionButton.setTitle("Register", for: .normal)
        
        // Auto sign out if the "Keep me logged in" is not switched on
        // Use of user defaults
        let retrievedLoggedIn = self.defaults.string(forKey: kUserLoggedInID)
        if retrievedLoggedIn == "Off" {
            do {
                try Auth.auth().signOut()
            } catch {
                print("Sign out error")
            }
        }
        // Perform login
        Auth.auth().addStateDidChangeListener() {
            auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                self.usernameField = nil
                self.passwordField = nil
                self.passwordConfirmField = nil
            }
        }
    }
    
    // When the big green button is pressed, if it says login, perform segue
    @IBAction func actionButtonPress(_ sender: Any) {
        if actionItem == "login" {
            Auth.auth().signIn(withEmail: usernameField.text!, password: passwordField.text!) {
                authResult, error in
                if let error = error as NSError? {
//                    self.errorMessage.text = "\(error.localizedDescription)"
                    print(error)
                } else {
//                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
//                    self.errorMessage.text = ""
                }
            }
        } else if actionItem == "register" {
            let username = usernameField.text
            // Only proceed if both passwords are matching
            if passwordField.text == passwordConfirmField.text {
                let password = passwordField.text
                // Create a user and write any errors if there are any
                Auth.auth().createUser(withEmail: username!, password: password!) {
                    authResult, error in
                    if let error = error as NSError? {
                        print(error)
//                        self.statusField.text = "\(error.localizedDescription)"
                    } else {
//                        self.statusField.text = ""
                    }
                }
            // Send a status message if passwords are not the same
            } else {
//                statusField.text = "Passwords do not match"
            }
        }
    }
    
    // When "Or login instead" is clicked, if it says register, turn into login screen
    // or vice versa
    @IBAction func alternateActionButtonPress(_ sender: Any) {
        if actionItem == "register" {
            UIView.animate(withDuration: 1,
                           animations: {
                self.passwordConfirmLabel.alpha = 0
                self.passwordConfirmField.alpha = 0
            },
                           completion: {
                done in
                self.passwordConfirmLabel.isHidden = true
                self.passwordConfirmField.isHidden = true
                self.actionButton.setTitle("Login", for: .normal)
                self.alternateActionButton.setTitle("Create an account", for: .normal)
                self.actionItem = "login"
            })
        } else if actionItem == "login" {
            UIView.animate(withDuration: 1,
                           animations: {
                self.passwordConfirmLabel.alpha = 1
                self.passwordConfirmField.alpha = 1
            },
                           completion: {
                done in
                self.passwordConfirmLabel.isHidden = false
                self.passwordConfirmField.isHidden = false
                self.actionButton.setTitle("Register", for: .normal)
                self.alternateActionButton.setTitle("Or login instead", for: .normal)
                self.actionItem = "register"
            })

        }
    }
}
