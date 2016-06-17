//
//  DetailViewController.swift
//  TweeterClientApp
//
//  Created by Olesia Kalashnik on 6/15/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Identity {
    
    @IBOutlet weak var tweetLable: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var tweet: Tweet?
    
    //get reference to cache (from AppDelegate)
    var cache : Cache<UIImage>?{
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            return delegate.cache
        }
        return nil
    }
    
    func setupOutlets() {
        if let tweet = self.tweet, user = tweet.user {
            if let originalTweet = tweet.retweet, originalAuthor = originalTweet.user{
                self.title = "Retweet"
                self.tweetLable.text = originalTweet.text
                self.userLabel.text = originalAuthor.screenName
                
                self.getUserImage(originalAuthor.profileImageURL, completion: { (image) in
                    
                    self.userImageView.image = image
                    
                })
            }
            else {
                self.title = "Tweet"
                self.tweetLable?.text = tweet.text
                self.userLabel?.text = user.screenName
                
                self.getUserImage(user.profileImageURL, completion: { (image) in
                    self.userImageView.image = image
                })
            }
        }
    }
    
    func getUserImage(key: String, completion: (image: UIImage) -> ()){
        if let image = cache?.read(key){
            completion(image: image)
            return
        }
        
        API.shared.fetchImage(key) { (image) in
            self.cache?.write(image, key: key)
            completion(image: image)
            return
        }
    }
    
    
    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupOutlets()
    }
    
    //MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == ProfileViewController.id() {
            let dest = segue.destinationViewController as UIViewController
            if let navController = dest as? UINavigationController {
                if let destination = navController.visibleViewController {
                    if let profileVC = destination as? ProfileViewController {
                        guard let safeTweet = self.tweet else { return }
                        if let originalAuthor = safeTweet.retweet?.user {
                            profileVC.user = originalAuthor
                        } else {
                            profileVC.user = safeTweet.user
                        }
                    }
                }
            }
        }
        else {
            if segue.identifier == AuthorTweetsViewController.id() {
                if let authorTweetVC = segue.destinationViewController as? AuthorTweetsViewController {
                    authorTweetVC.tweet = self.tweet
                }
            }
        }
    }
    
    
    
}
