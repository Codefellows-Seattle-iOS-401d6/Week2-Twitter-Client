//
//  ViewController.swift
//  TwitterClone
//
//  Created by Sung Kim on 6/13/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var datasource = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        JSONParser.tweetJSONFrom(JSONParser.JSONData()) {(success, tweets) in
            if success {
                if let tweets = tweets {
                    self.datasource = tweets
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}

extension ViewController: UITableViewDataSource {
    func tableView (tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.datasource.count
    }
    
    func tableView (tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath)
        let tweet = self.datasource[indexPath.row]
        cell.textLabel?.text = tweet.text
        return cell
    }
    
    
}

