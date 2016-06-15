//
//  tweet.swift
//  derekg.week2
//
//  Created by Derek Graham on 6/13/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

import Foundation

class Tweet
{
    let message : String
    let id : String
    let user : User?
    
    var retweet: Tweet?
    
    init?(json : [String: AnyObject])
    {
        if let message = json["text"] as? String,
            id = json["id_str"] as? String,
            user = json["user"] as? [String : AnyObject]
        {
            
            self.message = message
            self.id = id
            self.user = User( json : user )
            
            if let retweetJSON = json["retweeted_status"] as? [String : AnyObject] {
                if let retweet = Tweet(json : retweetJSON){
                    self.retweet = retweet
                }
            
            }
            
        } else {
            return nil
        }
        
    }
}