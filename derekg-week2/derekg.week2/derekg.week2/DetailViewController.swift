//
//  DetailViewController.swift
//  derekg.week2
//
//  Created by Derek Graham on 6/15/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Identity {

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var tweet : Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let tweet = self.tweet {
            
            if let retweet = tweet.retweet {
                self.tweetLabel.text = retweet.message
                self.userNameLabel.text = retweet.user?.name
            } else {
                self.tweetLabel.text = tweet.message
                self.userNameLabel.text = tweet.user?.name
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
