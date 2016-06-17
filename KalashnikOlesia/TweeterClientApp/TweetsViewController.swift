//
//  TweetsViewController.swift
//  TweeterClientApp
//
//  Created by Olesia Kalashnik on 6/13/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.estimatedRowHeight = 100
            self.tableView.rowHeight = UITableViewAutomaticDimension
            self.tableView.delegate = self
            
            //register NIB file
            self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: TweetCellTableViewCell.id())
        }
    }
    
    //get reference to cache (from AppDelegate)
    var cache : Cache<UIImage>?{
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            return delegate.cache
        }
        return nil
    }
    
    
    var selectedTweetIndex : NSIndexPath?
    
    private struct Storyboard {
        static let CellID = "tweetCell"
    }
    
    var tweets = [Tweet]() {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    func updateTweets() {
        API.shared.fetchTweets { (tweets) in
            if let unwrappedTweets = tweets {
                self.tweets = unwrappedTweets
            }
            if let accountName = API.shared.account?.username {
                self.title = "@\(accountName)"
            }
        }
    }
    
    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.updateTweets()
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.selectedTweetIndex = indexPath
        }
        
        if segue.identifier == DetailViewController.id() {
            if let path = self.selectedTweetIndex {
                if let detailVC = segue.destinationViewController as? DetailViewController {
                    detailVC.tweet = self.tweets[path.row]
                }
            }
        }
    }
}

// MARK: UITableViewDataSource and UITableViewDelegate Methods
extension TweetsViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TweetCellTableViewCell.id(), forIndexPath: indexPath) as! TweetCellTableViewCell
        let tweet = self.tweets[indexPath.row]
        cell.tweet = tweet
        
        return cell
    }
}

extension TweetsViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(DetailViewController.id(), sender: nil)
    }
}