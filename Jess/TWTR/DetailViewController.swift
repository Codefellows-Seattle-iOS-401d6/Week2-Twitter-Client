//
//  DetailViewController.swift
//  TWTR
//
//  Created by Jess Malesh on 6/15/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Identity {

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
    var tweet: Tweet?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let retweet = tweet?.retweet
        {
            self.tweetLabel.text = retweet.text
            self.userLabel.text = retweet.user?.name
        } else if let tweet = self.tweet
        {
            self.tweetLabel.text = tweet.text
            self.userLabel.text = tweet.user?.name
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    }
