//
//  DetailedViewController.swift
//  TwitterApp
//
//  Created by Jeffrey Eng on 6/15/16.
//  Copyright © 2016 Jeffrey Eng. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController, Identity {
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = self.tweet {
            if let retweet = tweet.retweet {
                print(retweet.text)
                self.tweetLabel.text = retweet.text
                self.userLabel.text = retweet.user?.name
            }
            
            else {
                print(tweet.text)
                self.tweetLabel.text = tweet.text
                self.userLabel.text = tweet.user?.name
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
