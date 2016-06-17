//
//  ViewController.swift
//  TWTR
//
//  Created by Rick  on 6/13/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    
    var cache : Cache<UIImage>? {
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate{
            return delegate.cache
        }
        return nil
    }
    
    var datasource = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupTableView()
        self.navigationItem.title = "TWRT"
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.update()
    }
    
    func setupTableView()
    {
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "tweetCell")
        self.tableView.delegate = self
    }
    
    
    func update()
    {
        API.shared.getTweets { (tweets) -> () in
            if let tweets = tweets {
                self.datasource = tweets
            }
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == DetailedViewController.id() {
            guard let detailViewController = segue.destinationViewController as? DetailedViewController else { return }
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            detailViewController.tweet = self.datasource[indexPath.row]
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(DetailedViewController.id(), sender: nil)
    }
    
}

extension ViewController: UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.datasource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetCell
        
        let tweet = self.datasource[indexPath.row]
        
        
        cell.tweet = tweet
        
        
        return cell
    }
}


