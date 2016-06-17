//
//  DetailViewController.swift
//  PianoBar
//
//  Created by David Swaintek on 6/16/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Identity {
    // MARK: Properties

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
