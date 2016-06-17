//
//  Tweet.swift
//  PianoBar
//
//  Created by David Swaintek on 6/13/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

import Foundation

class Tweet
{
    let text: String
    let id: String
    let user: User?
    var retweet: Tweet?
    
    init?(json: [String : AnyObject])
    {
        if let text = json["text"] as? String, id = json["id_str"] as? String, user = json["user"] as?
            [String : AnyObject] {
            self.text = text
            self.id = id
            self.user = User(json: user)
            
            //Create retweet tweet if applicable
            
            if let retweetJSON = json["retweeted_status"] as? [String : AnyObject] {
                if let retweet = Tweet(json: retweetJSON) {
                    self.retweet = retweet
                }
            }
        }
        else {
            return nil
        }
    }
}