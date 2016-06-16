//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by Sung Kim on 6/15/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, Identity
{

    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileLocationLabel: UILabel!
    @IBOutlet weak var profileImageLabel: UIImageView!
    
    @IBAction func closeButtonSelected(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        API.shared.GETOAuthoUser { (user) in
            if let user = user {
                self.profileNameLabel.text = user.name
                self.profileLocationLabel.text = user.location
                guard let imgURL = NSURL(string: user.profileImageUrl) else { return }
                guard let imgData = NSData(contentsOfURL: imgURL) else { return }
                self.profileImageLabel.image = UIImage(data: imgData)
            }
        }
    }
}
