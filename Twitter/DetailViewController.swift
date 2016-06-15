//
//  DetailViewController.swift
//  TWTR
//
//  Created by Sean Champagne on 6/15/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Identity
{
    var tweet: Tweet?
    @IBOutlet weak var tweetLabel: UILabel!

    @IBOutlet weak var userLabel: UILabel!

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
