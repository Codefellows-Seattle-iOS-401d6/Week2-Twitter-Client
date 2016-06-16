//
//  ViewController.swift
//  TWTR
//
//  Created by Sean Champagne on 6/15/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var tableView: UITableView!
    
    var datasource = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.update()
    }
    
    func setUpTableView()
    {
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func update()
    {
        API.shared.getTweets {(tweets) in
            if let tweets = tweets {
                self.datasource = tweets
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TWTR"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == DetailViewController.id()
        {
            guard let detailViewController = segue.destinationViewController as? DetailViewController else { return }
            let indexPath = self.tableView.indexPathForSelectedRow
            detailViewController.tweet = self.datasource[indexPath!.row]
        }
    
//        if segue.identifier == ProfileViewController.id()
//        {
//            guard let profileViewController = segue.destinationViewController as? ProfileViewController else { return }
//            let indexPath = self.tableView.indexPathForSelectedRow
//            profileViewController.user = self.datasource[indexPath!.row]
//        }
    }
    
}

extension ViewController: UITableViewDataSource
    {
        
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