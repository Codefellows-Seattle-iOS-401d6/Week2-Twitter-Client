//
//  DetailViewController.swift
//  TwitterClone
//
//  Created by Jeremy Moore on 6/15/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Identity
{

    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var userLabel: UILabel!
    
    let appColor = UIColor(
        red: 0xff/255,
        green: 0xf0/255,
        blue: 0xa5/255,
        alpha: 1.0)

    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = self.tweet {
            if let retweet = tweet.retweet {
                self.tweetLabel.text = retweet.text
                self.userLabel.text = retweet.user?.name
            } else {
                self.tweetLabel.text = tweet.text
                self.userLabel.text = tweet.user?.name
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        view.backgroundColor = appColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

   
}
