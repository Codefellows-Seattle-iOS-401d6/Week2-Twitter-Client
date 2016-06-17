//
//  ProfileViewController.swift
//  derekg.week2
//
//  Created by Derek Graham on 6/15/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, Identity {

    @IBOutlet weak var activityViewController: UIActivityIndicatorView!
  
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userLocationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userNameLabel.hidden = true
        self.userLocationLabel.hidden = true
        
        self.activityViewController.startAnimating()
        
        API.shared.GETOAuthUser { (user) in
            self.userNameLabel.text = user?.name
            self.userLocationLabel.text = user?.location
            
            self.activityViewController.stopAnimating()
            
            self.userNameLabel.hidden = false
            self.userLocationLabel.hidden = false
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func closeButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true,
                                           completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
