//
//  UserTimelineViewController.swift
//  TwitterClone
//
//  Created by Jeremy Moore on 6/16/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController, UITableViewDelegate, Identity
{
    @IBOutlet weak var tableView: UITableView!
    
    
    let appColor = UIColor(
        red: 0xff/255,
        green: 0xf0/255,
        blue: 0xa5/255,
        alpha: 1.0)
    
    var cache: Cache<UIImage>? {
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate{
            return delegate.cache
        }
        return nil
    }
    
    var tweet: Tweet?
    var tweets = [Tweet]() {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    func setupTableview() {
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "tweetCell")
        self.tableView.delegate = self
    }

    
    func update(userName: String){
        
        API.shared.getUserTweets(userName) { (tweets) in
            guard let tweets = tweets else { return}
            self.tweets = tweets
        }
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetCell
        let tweet = self.tweets[indexPath.row]
        cell.backgroundColor = appColor
        cell.tweet = tweet
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupTableview()
        
        if let tweet = self.tweet, user = tweet.user{
            if let originalTweet = tweet.retweet, originalUser = originalTweet.user{
                self.update(originalUser.userName)
            }
            else {
                self.update(user.userName)
            }
        }
        
    }

}








