//
//  DetailedViewController.swift
//  TWTR
//
//  Created by Rick  on 6/15/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController, Identity {

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
    var tweet: Tweet?
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let tweet = self.tweet {
            self.tweetLabel.text = tweet.text
            self.userLabel.text = tweet.user?.name
            
            if let retweet = tweet.retweet {
                self.tweetLabel.text = retweet.text
                self.userLabel.text = retweet.user?.name
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
