//
//  ViewController.swift
//  TWTR
//
//  Created by Jess Malesh on 6/13/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
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
    
    var portsource = [User](){
        didSet {
            self.portView.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.title = "TWRT"
        
        func setupTableView()
            {
                self.tableView.estimatedRowHeight = 100
                self.tableView.rowHeight = UITableViewAutomaticDimension
        }

    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
      self.update()
    }
    
      func update() {
            API.shared.getTweets { (tweets) in
                if let tweets = tweets{
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
        if segue.identifier == DetailViewController.id()
        {
            guard let detailViewController = segue.destinationViewController as? DetailViewController else { return }
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            detailViewController.tweet = self.datasource[indexPath.row]
        }
   
        if segue.identifier == ProfileViewController.id()
        {
            guard let profileViewController = segue.destinationViewController as? ProfileViewController else { return }
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            profileViewController.user = self.datasource[indexPath.row]
        }
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
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath)
        let tweet = self.datasource[indexPath.row]
        
        cell.textLabel?.text = tweet.text
        
        return cell
    }
}



























