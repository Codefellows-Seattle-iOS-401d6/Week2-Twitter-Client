//
//  AuthorTweetsViewController.swift
//  TweeterClientApp
//
//  Created by Olesia Kalashnik on 6/16/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import UIKit

class AuthorTweetsViewController: UIViewController, UITableViewDataSource, Identity {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.estimatedRowHeight = 100
            self.tableView.rowHeight = UITableViewAutomaticDimension
            self.tableView.dataSource = self
            
            //register NIB file
            self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: TweetCellTableViewCell.id())
        }
    }
    var tweet : Tweet?
    
    var cache : Cache<UIImage>?{
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            return delegate.cache
        }
        return nil
    }
    
    var tweets : [Tweet]? {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let tweet = self.tweet, user = tweet.user {
            if let originalTweet = tweet.retweet, originalAuthor = originalTweet.user {
                self.title = originalAuthor.name
                self.update(originalAuthor.screenName)
            } else {
                self.title = user.name
                self.update(user.screenName)
            }
        }
    }
    
    func update(screenName: String) {
        API.shared.getUserTweets(screenName) { (tweets) in
            if let safeTweets = tweets {
                self.tweets = safeTweets
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = self.tweets {
            return tweets.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TweetCellTableViewCell.id(), forIndexPath: indexPath) as! TweetCellTableViewCell
        if let safeTweet = self.tweets?[indexPath.row] {
            cell.tweet = safeTweet
        }
        return cell
    }
    
}