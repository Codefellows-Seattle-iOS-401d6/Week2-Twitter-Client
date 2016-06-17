//
//  TweetCell.swift
//  TwitterClone
//
//  Created by Jeremy Moore on 6/16/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    

    var cache: Cache<UIImage>? {
    if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate{
        return delegate.cache
    }
    return nil
    }

    var tweet: Tweet! {
        didSet {
            self.tweetLabel.text = tweet.text
            
            if let user = self.tweet.user {
                self.userNameLabel.text = user.userName
                if let image = cache?.read(user.profileImageUrl) {
                    self.userImageView.image = image
                    return
                }
                API.shared.getImage(user.profileImageUrl, completion: { (image) in
                    self.cache?.write(image, key: user.profileImageUrl)
                    self.userImageView.image = image
                })
            }
        }
    }
    
    func setupTweetCell () {
        self.userImageView.clipsToBounds = true
        self.userImageView.layer.cornerRadius = 15.0
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTweetCell()
    }
    
}