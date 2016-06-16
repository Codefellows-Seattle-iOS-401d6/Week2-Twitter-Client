//
//  DetailViewController.swift
//  derekg.week2
//
//  Created by Derek Graham on 6/15/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Identity {

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    
    var tweet : Tweet?
    
    var cache: Cache<UIImage>? {
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate{
            return delegate.cache
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        
//        if let tweet = self.tweet {
//            
//            if let retweet = tweet.retweet {
//                self.tweetLabel.text = retweet.message
//                self.userNameLabel.text = retweet.user?.name
//            } else {
//                self.tweetLabel.text = tweet.message
//                self.userNameLabel.text = tweet.user?.name
//                
//                let url = NSURL(string: (tweet.user?.profileImageUrl)!)
//                let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
//                userImage.image = UIImage(data: data!)
//                
//            }
//        }

        // Do any additional setup after loading the view.
    }

    func setup() {
        if let tweet = self.tweet, user = tweet.user {
            if let originalTweet = tweet.retweet, originalUser = originalTweet.user {
                self.navigationItem.title = "Retweet"
                self.tweetLabel.text = originalTweet.message
                self.userNameLabel.text = originalUser.name
                
                self.profileImage(originalUser.profileImageUrl, completion: { (image) in
                    self.userImage.image = image
                })
            }
         else {
            self.navigationItem.title = "Tweet"
            self.tweetLabel.text = tweet.message
            self.userNameLabel.text = tweet.user?.name
            
                self.profileImage((tweet.user?.profileImageUrl)!, completion: { (image) in
                    self.userImage.image = image
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func profileImage(key: String, completion: (image: UIImage)->()){
        if let image = cache?.read(key){
            completion(image: image)
            return
        }
        API.shared.getProfileImage(key) { (image) in
            self.cache?.write(image, key: key)
            completion(image: image)
            return
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
