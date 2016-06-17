//
//  UserTimeLineViewController.swift
//  derekg.week2
//
//  Created by Derek Graham on 6/16/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

import UIKit

class UserTimeLineViewController: UIViewController, UITableViewDataSource, Identity {
        
    @IBOutlet weak var tableView: UITableView!
    var tweet: Tweet?
    var tweets = [Tweet](){
        didSet{
            self.tableView.reloadData()
    
        }
    }

    var cache: Cache<UIImage>? {
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate{
            return delegate.cache
        }
        return nil
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        
        if let tweet = self.tweet, user = tweet.user{
            if let originalTweet = tweet.retweet, originalUser = originalTweet.user{
                self.navigationItem.title = originalUser.name
                self.update(originalUser.screenName)
            }
            else {
                self.navigationItem.title = user.screenName
                
                self.update(user.screenName)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView() {
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
//        self.navigationItem.title = "DEREKG"
        self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "tweetCell")
        self.tableView.dataSource = self
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(UserTimeLineViewController.id(), sender: nil)
    }
    
    

    func update(screenName: String){
        
        API.shared.getUserTweets(screenName) { (tweets) in
            guard let tweets = tweets else { return}
            self.tweets = tweets
        }
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tweetCell = self.tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetCell
        
        tweetCell.tweet = self.tweets[indexPath.row]
                
        return tweetCell
}
}
