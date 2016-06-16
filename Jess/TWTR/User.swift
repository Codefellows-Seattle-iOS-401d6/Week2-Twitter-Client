//
//  User.swift
//  TWTR
//
//  Created by Jess Malesh on 6/13/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

import Foundation

class User
{
    let name: String?
    let profileImageUrl: String?
    let location: String
    var user: User?
    var profile: User?
    var tweet: Tweet?
    
    init?(json: [String : AnyObject])
    {
        
        
        if let name = json["name"] as? String, profileImageUrl = json["profile_image_url"] as? String, location = json["location"] as? String, user =  json["user"] as? [String: AnyObject]      {
            self.name = name
            self.profileImageUrl = profileImageUrl
            self.location = location
            
            if let profile = User(json: user)
                {
                    self.profile = profile
                }
            }
            
        
        else {
            return nil
        }
    }
}
