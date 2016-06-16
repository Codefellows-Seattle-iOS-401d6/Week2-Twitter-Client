//
//  ViewController.swift
//  TwitterClone
//
//  Created by Sung Kim on 6/13/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
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

    var firstLogin = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupTableView()
        self.navigationItem.title = "TWRT"
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.selectUser()
        if !firstLogin {
            self.update()
            firstLogin = true
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == DetailViewController.id() {
            guard let detailViewController = segue.destinationViewController as? DetailViewController else { return }
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            detailViewController.tweet = self.datasource[indexPath.row]
        }
    }
    
    func update()
    {
        API.shared.login({ (accounts) in
            if let accounts = accounts {
                let alertController = UIAlertController(title: "Accounts", message: "Please choose account to display Twitter Feed", preferredStyle:.ActionSheet)
                for account in accounts {
                    let action = UIAlertAction(title: account.username, style: .Default) { (action) in
                        API.shared.account = account
                        API.shared.getTweets { (tweets) in
                            if let tweets = tweets {
                                self.datasource = tweets
                            }
                        }
                    }
                    alertController.addAction(action)
                }
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        })
    }

    func setupTableView() {
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func selectUser() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Accounts", style: .Plain, target: self, action: #selector(update))
    }
}

extension ViewController: UITableViewDataSource
{
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




