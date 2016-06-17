//
//  ProfileViewController.swift
//  PianoBar
//
//  Created by David Swaintek on 6/16/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closeButtonSelected(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        API.shared.GETOAuthUser { (user) in
            print(user)
        }
    }

}
