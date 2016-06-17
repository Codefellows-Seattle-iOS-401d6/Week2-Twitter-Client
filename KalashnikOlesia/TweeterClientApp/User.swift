//
//  User.swift
//  TweeterClientApp
//
//  Created by Olesia Kalashnik on 6/13/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import Foundation
class User {
    let name : String
    let location: String
    let profileImageURL : String
    var screenName : String
    
    init?(json:[String:AnyObject]) {
        if let name = json["name"] as? String,
            location = json["location"] as? String,
            profileImageURL = json["profile_image_url"] as? String,
            screenName = json["screen_name"] as? String {
            self.name = name
            self.location = location
            self.profileImageURL = profileImageURL
            self.screenName = screenName
            
        } else {
            return nil
        }
    }
}