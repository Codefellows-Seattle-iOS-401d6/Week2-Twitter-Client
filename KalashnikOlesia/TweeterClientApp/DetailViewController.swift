//
//  DetailViewController.swift
//  TweeterClientApp
//
//  Created by Olesia Kalashnik on 6/15/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Identity {
    
    @IBOutlet weak var tweetLable: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
    var tweet: Tweet? {
        didSet {
            if let retweet = self.tweet!.retweet {
                self.tweet = retweet
            }
        }
    }
    
    func displayTweetAndUsername() {
        guard let safeTweet = tweet else { return }
        self.tweetLable?.text = safeTweet.text
        self.userLabel?.text = safeTweet.user?.name
    }
    
    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        displayTweetAndUsername()
    }
    
    //MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == ProfileViewController.id() {
            let dest = segue.destinationViewController as UIViewController
            if let navController = dest as? UINavigationController {
                if let destination = navController.visibleViewController {
                    if let profileVC = destination as? ProfileViewController {
                        guard let safeTweet = self.tweet else { return }
                        profileVC.user = safeTweet.user
                    }
                }
            }
        }
    }
    
}
