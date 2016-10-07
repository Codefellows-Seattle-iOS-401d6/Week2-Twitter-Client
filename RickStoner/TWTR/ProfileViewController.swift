//
//  ProfileViewController.swift
//  TWTR
//
//  Created by Rick  on 6/15/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, Identity {

    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        func getProfile() {
            API.shared.GETOAuthUser { (user) in
                
                if let user = user {
                    
                    self.name.text = user.name
                    self.location.text = user.location
                    guard let image = NSURL(string: user.profileImageUrl) else { return }
                    guard let imgData = NSData(contentsOfURL: image) else { return }
                    NSOperationQueue.mainQueue().addOperationWithBlock({
                        self.userImage.layer.cornerRadius = 50
                        self.userImage.image = UIImage(data: imgData)
                    })
                    
                }
            }
        }
        
        getProfile()
    }

    @IBAction func close(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}
