//
//  ViewController.swift
//  TwitterClone
//
//  Created by Jeremy Moore on 6/13/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Identity
{
        
    @IBOutlet weak var tableView: UITableView!
    
    let appColor = UIColor(
        red: 0xff/255,
        green: 0xf0/255,
        blue: 0xa5/255,
        alpha: 1.0)

    var datasource = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    func setupTableview() {
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.update()
        view.backgroundColor = appColor
        navigationController?.navigationBar.barTintColor = appColor

    }
    
    func update () {
        API.shared.getTweets { (tweets) in
            if let tweets = tweets {
                self.datasource = tweets
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == DetailViewController.id() {
            guard let DetailViewController = segue.destinationViewController as? DetailViewController else {
                return }
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            DetailViewController.tweet = self.datasource[indexPath.row]
        }
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
            cell.backgroundColor = appColor
            return cell
        }
}

