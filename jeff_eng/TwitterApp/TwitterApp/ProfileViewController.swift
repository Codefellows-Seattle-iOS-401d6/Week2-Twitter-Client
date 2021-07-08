//
//  ProfileViewController.swift
//  TwitterApp
//
//  Created by Jeffrey Eng on 6/15/16.
//  Copyright © 2016 Jeffrey Eng. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, Identity {
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        API.shared.GETOAuthUser { (user) in
            if let currentUser = user {
                print("Hello \(currentUser.name)")
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self.currentUser = currentUser
                    self.userLabel.text = currentUser.name
                    self.locationLabel.text = currentUser.location
                })

            }
                
            else {
                print("No user info!!!!")
            }
        }
        
    }
    
    @IBAction func closeButtonSelected(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
