//
//  ProfileViewController.swift
//  TWTR
//
//  Created by Jess Malesh on 6/15/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, Identity
{
    @IBOutlet weak var userImage: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    
    var user: User?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        API.shared.GETOAuthUser { (user) in
            print(user)
        }
    }
    
    @IBAction func closeButtonSelected(sender: UIButton)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
