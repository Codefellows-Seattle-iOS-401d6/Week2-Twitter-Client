//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by Jeremy Moore on 6/15/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, Identity {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var currentUser: User?

    let appColor = UIColor(
        red: 0xff/255,
        green: 0xf0/255,
        blue: 0xa5/255,
        alpha: 1.0)


    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        API.shared.GETOAuthUsser { (user) in
            self.currentUser = user
        NSOperationQueue.mainQueue().addOperationWithBlock({ 
            self.userNameLabel.text = self.currentUser?.name
            self.locationLabel.text = self.currentUser?.location
            if let url = NSURL(string: (self.currentUser?.profileImageUrl)!)
            {
                let data = NSData(contentsOfURL: url)
                self.profileImageView.image = UIImage(data: data!)
            }
            })
        }
        view.backgroundColor = appColor
    }
    
    @IBAction func closeButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
