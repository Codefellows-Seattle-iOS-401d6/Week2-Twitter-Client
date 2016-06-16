//
//  DetailViewController.swift
//  TWTR
//
//  Created by Sean Champagne on 6/15/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Identity
{
    var tweet: Tweet?
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    var cache: Cache<UIImage>? {
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate{
            return delegate.cache
        }
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

//        if let tweet = self.tweet {
//            
//            if let retweet = tweet.retweet {
//                self.tweetLabel.text = retweet.text
//                self.userLabel.text = retweet.user?.name
//            } else {
//            self.tweetLabel.text = tweet.text
//            self.userLabel.text = tweet.user?.name
//            }
//        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == UserTimelineViewController.id()
        {
            let UserTimelineViewController = segue.destinationViewController as! UserTimelineViewController
            UserTimelineViewController.tweet = self.tweet
        }
    }

    
    func setup()
    {
        if let tweet = self.tweet, user = tweet.user
        {
            if let originalTweet = tweet.retweet, originalUser = originalTweet.user
            {
                self.navigationItem.title = "Retweet"
                self.tweetLabel.text = originalTweet.text
                self.userLabel.text = originalUser.name
                self.profileImage(originalUser.profileImageUrl, completion: { (image) in
                        self.profileImageView.image = image
                    })
            }
            else
            {
                self.navigationItem.title = "Tweet"
                self.tweetLabel.text = tweet.text
                self.userLabel.text = user.name
                self.profileImage(user.profileImageUrl, completion: { (image) in
                    self.profileImageView.image = image })
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func profileImage(key: String, completion: (image: UIImage) -> ())
    {
        if let image = cache?.read(key)
        {
            completion(image: image)
            return
        }
        API.shared.getImage(key, completion: { (image) in
            self.cache?.write(image, key: key)
            completion(image: image)
            return
        })
    }
}
