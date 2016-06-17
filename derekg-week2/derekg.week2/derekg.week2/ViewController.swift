//
//  ViewController.swift
//  derekg.week2
//
//  Created by Derek Graham on 6/13/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    
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
    var cache: Cache<UIImage>? {
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate{
            return delegate.cache
        }
        return nil
    }

//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        
//      
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        
        self.update()

        
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
    
    func setupTableView() {
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.navigationItem.title = "DEREKG"
        self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "tweetCell")
        self.tableView.delegate = self
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == DetailViewController.id() {
            guard let detailViewController = segue.destinationViewController as? DetailViewController   else { return }
            
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            
            detailViewController.tweet = self.datasource[indexPath.row]
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(DetailViewController.id(), sender: nil)
    }
    
    func update() {
        
        API.shared.getTweets( { (tweets) in
            if let tweets = tweets {
                self.datasource = tweets
            }
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let row = tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(row, animated: false)
        }
    }

    

}

extension ViewController : UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetCell
        
        let tweet = self.datasource[indexPath.row]
        
//      cell.textLabel?.text = tweet.message
        cell.tweet = tweet
        return cell
    }
    
    
    
}