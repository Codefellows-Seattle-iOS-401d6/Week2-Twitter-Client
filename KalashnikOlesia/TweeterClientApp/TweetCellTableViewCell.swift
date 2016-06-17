//
//  TweetCellTableViewCell.swift
//  TweeterClientApp
//
//  Created by Olesia Kalashnik on 6/16/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell, Identity {
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    var cellHeight = UITableViewAutomaticDimension
    
    //get reference to cache (from AppDelegate)
    var cache : Cache<UIImage>?{
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            return delegate.cache
        }
        return nil
    }
    
    var tweet : Tweet? {
        //update all outlets once tweet value is set
        didSet {
            self.tweetTextLabel.text = tweet!.text
            if let user = self.tweet!.user {
                self.userNameLabel?.text = user.screenName
                setUserImage(user)
                self.setupTweetCell()
            }
        }
    }
    
    func setUserImage(user: User) {
        //if image is cached
        if let image = cache?.read(user.profileImageURL) {
            self.userImageView?.image = image
            return
        }
        //if image is not cached
        API.shared.fetchImage(user.profileImageURL, completion: { (image) in
            self.cache?.write(image, key: user.profileImageURL)
            self.userImageView?.image = image
        })
    }
    
    //UI cell setup
    func setupTweetCell() {
        self.userImageView?.clipsToBounds = true
        self.userImageView?.layer.cornerRadius = 15.0
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0)
    }
    
    
    
    
}
