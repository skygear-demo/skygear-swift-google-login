//
//  ViewController.swift
//  SkygearGoogleOAuthDemo
//
//  Created by Elliot Ng on 06/16/2018.
//  Copyright (c) 2018 Elliot Ng. All rights reserved.
//

import UIKit
import SKYKit

class ViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var loginStatusLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.updateLoginStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateLoginStatus() {
        if ((SKYContainer.default().auth.currentUserRecordID) != nil) {
            loginStatusLabel.text = "Logged in"
            loginButton.isEnabled = false
            signupButton.isEnabled = false
            logoutButton.isEnabled = true
        } else {
            loginStatusLabel.text = "Not logged in"
            loginButton.isEnabled = true
            signupButton.isEnabled = true
            logoutButton.isEnabled = false
        }
    }
    
    func showAlert(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func didTapLogin(_ sender: AnyObject) {
        SKYContainer.default().auth.login(withUsername: usernameField.text!, password: passwordField.text!) { (user, error) in
            if let authError = error {
                self.showAlert(authError)
                return
            }
            print("Logged in as: \(user?.recordID.recordName)")
            self.updateLoginStatus()
        }
    }
    
    @IBAction func didTapSignup(_ sender: AnyObject) {
        SKYContainer.default().auth.signup(withUsername: usernameField.text!, password: passwordField.text!) { (user, error) in
            if let authError = error {
                self.showAlert(authError)
                return
            }
            print("Signed up as: \(user?.recordID.recordName)")
            self.updateLoginStatus()
        }
    }
    
    @IBAction func didTapLogout(_ sender: AnyObject) {
        SKYContainer.default().auth.logout { (user, error) in
            if let authError = error {
                self.showAlert(authError)
                return
            }
            NSLog("Logged out")
            self.updateLoginStatus()
        }
    }
}

