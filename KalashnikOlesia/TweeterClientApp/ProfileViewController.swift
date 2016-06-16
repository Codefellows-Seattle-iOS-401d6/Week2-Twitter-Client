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
        let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
        let notMainQueue = dispatch_get_global_queue(qos, 0)
        dispatch_async(notMainQueue) { () -> Void in
            guard let url = NSURL(string: safeUser.profileImageURL) else { return }
            if let data = NSData(contentsOfURL: url) {
                dispatch_async(dispatch_get_main_queue())  { () -> Void in
                    self.profileImageView.image = UIImage(data: data)
                }
            }
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
