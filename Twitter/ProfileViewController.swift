//
//  ProfileViewController.swift
//  TWTR
//
//  Created by Sean Champagne on 6/15/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, Identity
{
    var user: User?
    //var imgUrl: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var profileImgLabel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        API.shared.GETOAuthUser { (user) in
            if let user = user {
                self.user = user
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    self.profileLabel.text = self.user?.name
                    self.locationLabel.text = self.user?.location
                    if let url = NSURL(string: (self.user?.profileImageUrl)!)
                    {
                        let data = NSData(contentsOfURL: url)
                        self.profileImgLabel.image = UIImage(data: data!)
                    }
                })

            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func closeButtonSelected(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
