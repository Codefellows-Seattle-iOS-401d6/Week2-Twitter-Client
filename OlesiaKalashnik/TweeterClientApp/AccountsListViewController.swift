//
//  AccountsListViewController.swift
//  TweeterClientApp
//
//  Created by Olesia Kalashnik on 6/14/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import UIKit
import Accounts

class AccountsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var accounts = [ACAccount]() {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    var selectedAccount : ACAccount?
    
    private struct Storyboard {
        static let AccountCellID = "AccountCell"
        static let SegueToTweets = "Segue To Tweets"
    }
    
    func updateAccounts() {
        if let allAccs = API.shared.allAccounts {
            self.accounts = allAccs
        }
    }
    
    // MARK: - ViewController Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.updateAccounts()
    }
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.SegueToTweets {
            let dest = segue.destinationViewController as UIViewController
            if let navController = dest as? UINavigationController {
                if let destination = navController.viewControllers.first {
                    if let TweetsVC = destination as? TweetsViewController {
                        
                        guard let selected = self.selectedAccount else {return}
                        TweetsVC.title = "@\(selected.username)"
                        //set account to the chosen one and fetch tweets
                        API.shared.account = selected
                        API.shared.fetchTweets { (tweets) in
                            if let unwrappedTweets = tweets {
                                TweetsVC.tweets = unwrappedTweets
                            }
                        }
                    }
                }
            }
        }
    }
    
}

extension AccountsListViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.accounts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.AccountCellID, forIndexPath: indexPath)
        cell.textLabel?.text = self.accounts[indexPath.row].username
        return cell
    }
}

extension AccountsListViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        self.selectedAccount = self.accounts[indexPath.row]
        return indexPath
    }
}