//
//  ViewController.swift
//  TWTR
//
//  Created by Sean Champagne on 6/13/16.
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
//        JSONParser.tweetJSONFrom(JSONParser.JSONData()) {
//            (success, tweets) in
//        if success {
//            if let tweets = tweets {
//                self.datasource = tweets
//                    }
//                }
//            }
        self.update()
        }
    //creating update function in the controller
    func update() {
        API.shared.getTweets {(tweets) in
            if let tweets = tweets {
                self.datasource = tweets
            }
        }
    }


    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
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

