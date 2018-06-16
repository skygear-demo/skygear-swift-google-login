//
//  LoginViewController.swift
//  SkygearGoogleOAuthDemo
//
//  Created by Chihim Ng on 16/6/2018.
//  Copyright © 2018 SkygearIO. All rights reserved.
//

import UIKit
import SKYKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!

    @IBAction func loginButtonPressed(_ sender: Any) {
        let options:[String:Any] = [
            "scheme": "skydemo",
            "scopes": ["email", "profile"]
        ]
        SKYContainer.default().auth.loginOAuthProvider("google", options: options) { (user, error) in
            guard user != nil && error == nil else {
                print("Login Failed")
                print(error.debugDescription)
                return
            }
            print("Login Success")
            print("User:", user!.dictionary.debugDescription)
            print("Access Token:", SKYContainer.default().auth.currentAccessToken!.tokenString)
            self.performSegue(withIdentifier: "profile", sender: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if SKYContainer.default().auth.currentUser != nil {
            self.performSegue(withIdentifier: "profile", sender: self)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
