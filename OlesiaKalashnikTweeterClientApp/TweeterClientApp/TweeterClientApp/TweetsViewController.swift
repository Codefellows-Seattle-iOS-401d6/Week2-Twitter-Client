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
            tableView.reloadData()
        }
    }
    
    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        JSONParser.tweetJSONFrom(JSONParser.JSONData()) { (successful, tweets) in
            if successful {
                self.tweets = tweets!
            }
        }
    }
}

// MARK: UITableViewDataSource methods
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

extension TweetsViewController : UITableViewDelegate {
    
}
