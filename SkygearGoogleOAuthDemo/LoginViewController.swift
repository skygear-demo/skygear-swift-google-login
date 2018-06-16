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
        let options = [
            "scheme": "skydemo"
        ]
        SKYContainer.default().auth.loginOAuthProvider("google", options: options) { (record, error) in
            guard record != nil && error == nil else {
                print("Login Failed")
                print(error.debugDescription)
                return
            }
            print("Login Success")
            print(record!.dictionary.debugDescription)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
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
