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


    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.selectUser()
        self.update()

//        JSONParser.tweetJSONFrom(JSONParser.JSONData()) {(success, tweets) in
//            if success {
//                if let tweets = tweets {
//                    self.datasource = tweets
//                }
//            }
//        }
    }
    
    func update()
    {
        API.shared.login({ (accounts) in
            if let accounts = accounts {
                let alertController = UIAlertController(title: "Select Account", message: "Please choose account to display Twitter Feed", preferredStyle:.ActionSheet)
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

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func selectUser() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select Account", style: .Plain, target: self, action: #selector(update))
    }
    
//    func alertUser() {
//        let alertController = UIAlertController(title: "Select Account", message: "Please choose account to display Twitter Feed", preferredStyle:.ActionSheet)
//    
//        
//        
//        let oneAction = UIAlertAction(title: "One", style: .Default) { (_) in }
//        let twoAction = UIAlertAction(title: "Two", style: .Default) { (_) in }
//        let threeAction = UIAlertAction(title: "Three", style: .Default) { (_) in }
//    
//        alertController.addAction(oneAction)
//        alertController.addAction(twoAction)
//        alertController.addAction(threeAction)
//
//        self.presentViewController(alertController, animated: true, completion: nil)
//    }
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




