//
//  ViewController.swift
//  derekg.week2
//
//  Created by Derek Graham on 6/13/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var datasource = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var accountIdentifier = String() {
        didSet {
            self.update()
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.update()


    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NSOperationQueue().addOperationWithBlock {
//            usleep(500000)
//            NSOperationQueue.mainQueue().addOperationWithBlock({
//                
//                
//            })
//        }
        
        // Do any additional setup after loading the view, typically from a nib.
//        JSONParser.tweetJSON(JSONParser.jsonData(), completion:
//            { ( success, tweets) in
//                if success {
//                    for tweet in tweets! {
//                        print(tweet.message)
//                    }
//                }
//        
//        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func update() {
        
        API.shared.getAccountStore { (accountStore) in
            if let accountStore = accountStore {
                
                let alertController = UIAlertController(title: "Multiple Twitter Accounts", message: "Choose an account", preferredStyle: .Alert)
                    for account in accountStore.accounts {
                        alertController.addAction(UIAlertAction(title: account.identifier, style: .Default) { (_) in })
                    }

                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
                alertController.addAction(cancelAction)
                
                self.presentViewController(alertController, animated: true) {
                    // ...
                }
                }
        }
        
        API.shared.getTweets( { (tweets) in
            if let tweets = tweets {
                self.datasource = tweets
            }
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
  
        

        
//        JSONParser.tweetJSON(JSONParser.jsonData(), completion:
//            { (success, tweets) in
//                if success {
//                    if let tweets = tweets {
//                        self.datasource = tweets
//                    }
//                }
//            
//        })
    }


}

extension ViewController : UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath)
        let tweet = self.datasource[indexPath.row]
        cell.textLabel?.text = tweet.message
        return cell
    }
}