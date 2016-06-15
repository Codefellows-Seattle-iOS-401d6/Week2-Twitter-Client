//
//  TweetsViewController.swift
//  TweeterClientApp
//
//  Created by Olesia Kalashnik on 6/13/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
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
}

// MARK: UITableViewDataSource and UITableViewDelegate Methods
extension TweetsViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellID, forIndexPath: indexPath)
        let tweet = self.tweets[indexPath.row]
        cell.textLabel?.text = tweet.text
        if let user = tweet.user {
            cell.detailTextLabel?.text = "@\(user.name)"
            cell.detailTextLabel?.textColor = UIColor.grayColor()
            
        }
        return cell
    }
}