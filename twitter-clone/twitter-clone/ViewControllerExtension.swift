//
//  ViewControllerExtension.swift
//  twitter-clone
//
//  Created by David Livingstone on 6/13/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import Foundation

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