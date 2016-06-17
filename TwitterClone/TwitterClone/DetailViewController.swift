//
//  DetailViewController.swift
//  TwitterClone
//
//  Created by Jeremy Moore on 6/15/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Identity
{

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    let appColor = UIColor(
        red: 0xff/255,
        green: 0xf0/255,
        blue: 0xa5/255,
        alpha: 1.0)

    var cache: Cache<UIImage>? {
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate{
            return delegate.cache
        }
        return nil
    }
    
    var tweet: Tweet?
    
    func profileImage (key: String, completion: (image: UIImage) -> ()) {
        if let image = cache?.read(key) {
            completion (image: image)
            return
        }
        API.shared.getImage(key) { (image) in
            self.cache?.write(image, key: key)
            completion(image: image)
            return
        }
    }
    
    func setupTable() {
        if let tweet = self.tweet, user = tweet.user {
            if let originalTweet = tweet.retweet, originalUser = originalTweet.user {
                self.tweetLabel.text = originalTweet.text
                self.userLabel.text = originalUser.name
                self.profileImage(originalUser.profileImageUrl, completion: { (image) in
                    self.profileImageView.image = image
                })
            } else {
                self.tweetLabel.text = tweet.text
                self.userLabel.text = user.name
                self.profileImage(user.profileImageUrl, completion: { (image) in
                    self.profileImageView.image = image
                    })
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == UserTimelineViewController.id() {
            guard let userTimelineViewController = segue.destinationViewController as? UserTimelineViewController else { return }
            userTimelineViewController.tweet = self.tweet
            }
    }
    
    override func viewWillAppear(animated: Bool) {
        view.backgroundColor = appColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

   
}
