//
//  ProfileViewController.swift
//  SkygearGoogleOAuthDemo
//
//  Created by Chihim Ng on 16/6/2018.
//  Copyright © 2018 SkygearIO. All rights reserved.
//

import UIKit
import SKYKit
import SwiftyJSON
import SDWebImage
import SVProgressHUD

class ProfileViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var userProfile:JSON? = nil

    @objc func logout() {
        SVProgressHUD.show()
        UIApplication.shared.beginIgnoringInteractionEvents() // Avoid double click
        SKYContainer.default().auth.logout { (user, error) in
            SVProgressHUD.dismiss()
            UIApplication.shared.endIgnoringInteractionEvents()
            guard error == nil else {
                print("Logout Failed")
                print(error.debugDescription)
                return
            }
            self.navigationController?.popViewController(animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // UI Setup
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.width / 2 // Round icon
        self.iconImageView.clipsToBounds = true
        self.iconImageView.sd_setShowActivityIndicatorView(true)
        self.tableView.tableFooterView = UIView(frame: .zero) // Hide bottom empty cells
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout)), animated: false)
        // Get Profile
        SVProgressHUD.show()
        SKYContainer.default().auth.getOAuthProviderProfiles(completionHandler: { (profile, error) in
            SVProgressHUD.dismiss()
            guard profile != nil && error == nil else {
                print("Failed Getting Profile")
                print(error.debugDescription)
                return
            }
            print("User Profile:", profile.debugDescription)
            self.userProfile = JSON(profile as Any)["google"]
            if let iconUrl = self.userProfile?["picture"].url {
                self.iconImageView.sd_setImage(with: iconUrl, completed: nil)
            }
            self.nameLabel.text = self.userProfile?["name"].stringValue
            self.tableView.reloadData()
        })
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

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userProfile?.dictionary?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let key = Array(self.userProfile!.dictionary!.keys)[indexPath.row]
        cell.textLabel?.text = key
        cell.detailTextLabel?.text = self.userProfile?[key].stringValue
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Google Profile"
    }
}

extension ProfileViewController: UITableViewDelegate {

}
