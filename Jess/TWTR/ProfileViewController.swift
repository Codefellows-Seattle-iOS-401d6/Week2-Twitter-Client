//
//  ProfileViewController.swift
//  TWTR
//
//  Created by Jess Malesh on 6/15/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, Identity {

    @IBOutlet weak var userImage: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let profile = user?.profile
        {
            self.userName.text = profile.name
            self.userLocation.text = profile.location
//            self.userImage.image = profile.text
            
        } else if let user = self.user
        {
            self.userName.text = user.name
            self.userLocation.text = user.location
        }
        
    }
    
    @IBAction func closeButtonSelector(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
