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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func closeButtonSelected(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
