//
//  TweetCellTableViewCell.swift
//  TwitterClone
//
//  Created by Sung Kim on 6/16/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var cache: Cache<UIImage>? {
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            return delegate.cache
        }
        return nil
    }
    
    var tweet: Tweet! {
        didSet {
            self.tweetLabel.text = tweet.text
            
            if let user = self.tweet.user {
                self.userNameLabel.text = user.screenName
                
                if let image = cache?.read(user.profileImageUrl) {
                    self.profileImageView.image = image
                    return
                }
                
                API.shared.getImage(user.profileImageUrl, completion: { (image) in
                    self.cache?.write(image, key: user.profileImageUrl)
                    self.profileImageView.image = image
                })
            }
        }
    }
 
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTweetCell()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupTweetCell() {
        self.profileImageView.clipsToBounds = true
        self.profileImageView.layer.cornerRadius = 15.0
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0)
        self.layoutMargins = UIEdgeInsetsZero
    }

}
