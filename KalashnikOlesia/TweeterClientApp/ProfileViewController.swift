//
//  ProfileViewController.swift
//  TweeterClientApp
//
//  Created by Olesia Kalashnik on 6/15/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, Identity {
    
    var user: User?
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    func updateOutlets() {
        self.fetchImage()
        guard let safeUser = self.user else { return }
        self.locationLabel?.text = safeUser.location
    }
    
    func fetchImage() {
        guard let safeUser = self.user else { return }
        
        guard let url = NSURL(string: safeUser.profileImageURL) else { return }
        if let data = NSData(contentsOfURL: url) {
            self.profileImageView.image = UIImage(data: data)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = self.user {
            self.title = user.name
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.updateOutlets()
    }
    
    
    @IBAction func closeProfile(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
