//
//  ViewController.swift
//  TWTR
//
//  Created by Rick  on 6/13/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit

class ViewController: UIViewController, Identity {
    
    @IBOutlet weak var tableView: UITableView!
    
    var datasource = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "TWTR"
        func setupTableView() {
            self.tableView.estimatedRowHeight = 100
            self.tableView.rowHeight = UITableViewAutomaticDimension
        }
        
    }
    
    
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    
    self.update()
        // Make the call.
//        JSONParser.tweetJSONFrom(JSONParser.JSONData()) { (success, tweets) in
//            if success {
//                if let tweets = tweets {
//                    self.datasource = tweets
//                }
//            }
//        }
    }
    
    func update(){
    
        API.shared.getTweets { (tweets) in
            if let tweets = tweets {
                self.datasource = tweets
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == DetailedViewController.id() {
            guard let detailedViewController = segue.destinationViewController as? DetailedViewController else { return }
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            detailedViewController.tweet = self.datasource[indexPath.row]
        }
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath)
        let tweet = self.datasource[indexPath.row]
        
        cell.textLabel?.text = tweet.text
        
        return cell
    }
}

