//
//  DetailViewController.swift
//  TwitterClone
//
//  Created by Sung Kim on 6/15/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, Identity
{

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
    var tweet: Tweet?
    
    var cache: Cache<UIImage>? {
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            return delegate.cache
        }
        return nil
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setup()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imgView.userInteractionEnabled = true
        imgView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == UserTimeLineViewController.id() {
            let userTimelineViewController = segue.destinationViewController as! UserTimeLineViewController
            userTimelineViewController.tweet = self.tweet
        }
    }
    func setup() {
        if let tweet = self.tweet, user = tweet.user {
            if let originalTweet = tweet.retweet, originalUser = originalTweet.user {
                self.navigationItem.title = "Retweet"
                self.tweetLabel.text = originalTweet.text
                self.userLabel.text = originalUser.name
                
                self.profileImage(originalUser.profileImageUrl, completion: { (image) in
                    self.imgView.image = image
                })
            } else {
                self.navigationItem.title = "Tweet"
                self.tweetLabel.text = tweet.text
                self.userLabel.text = user.name
                
                self.profileImage(user.profileImageUrl, completion: { (image) in
                    self.imgView.image = image
                })
            }
        }
    }
    
    func profileImage(key: String, completion: (image: UIImage) -> ()) {
        if let image = cache?.read(key) {
            completion(image: image)
            return
        }
        
        API.shared.getImage(key) { (image) in
            self.cache?.write(image, key: key)
            completion(image: image)
            return
        }
    }
    
    func imageTapped(sender: UITapGestureRecognizer) {
        self.performSegueWithIdentifier(UserTimeLineViewController.id(), sender: nil)
    }
}
