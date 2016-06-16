//
//  UserTimeLineViewController.swift
//  TwitterClone
//
//  Created by Sung Kim on 6/16/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit

class UserTimeLineViewController: UIViewController, UITableViewDataSource, Identity {

    @IBOutlet weak var userTableView: UITableView!
    
    var tweet: Tweet?
    var tweets = [Tweet]() {
        didSet {
            self.userTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        if let tweet = self.tweet, user = tweet.user {
            if let originalTweet = tweet.retweet, originalUser = originalTweet.user {
                self.navigationItem.title = originalUser.name
                self.update(originalUser.screenName)
            } else {
                self.navigationItem.title = user.screenName
                self.update(user.screenName)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTableView() {
        self.userTableView.registerNib(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "tweetCell")
        self.userTableView.dataSource = self
        
        self.userTableView.estimatedRowHeight = 100
        self.userTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func update(screenname: String) {
        API.shared.getUserTweets(screenname) { (tweets) in
            guard let tweets = tweets else { return }
            self.tweets = tweets
        }
    }
    

}

extension UserTimeLineViewController {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tweetCell = self.userTableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetCellTableViewCell
        
        tweetCell.tweet = self.tweets[indexPath.row]
        return tweetCell
    }
}
