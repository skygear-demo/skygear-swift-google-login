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
    let keysToDisplay:[String] = ["id", "email", "verified_email", "locale"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // UI Setup
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.width / 2 // Round icon
        self.iconImageView.clipsToBounds = true
        self.iconImageView.sd_setShowActivityIndicatorView(true)
        self.tableView.tableFooterView = UIView(frame: .zero) // Hide bottom empty cells

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
            self.userProfile = JSON(profile as Any)
            if let iconUrl = self.userProfile?["google"]["picture"].url {
                self.iconImageView.sd_setImage(with: iconUrl, completed: nil)
            }
            self.nameLabel.text = self.userProfile?["google"]["name"].stringValue ?? "Empty"
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
        return self.keysToDisplay.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let key = self.keysToDisplay[indexPath.row]
        cell.textLabel?.text = key
        cell.detailTextLabel?.text = self.userProfile?["google"][key].stringValue ?? "Empty"
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {

}
