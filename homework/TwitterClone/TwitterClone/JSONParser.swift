//
//  JSONParser.swift
//  TwitterClone
//
//  Created by Sung Kim on 6/13/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import Foundation

class JSONParser
{
    typealias JSONParserCompletion = (success: Bool, tweets: [Tweet]?) -> ()
    
    class func tweetJSONFrom(data: NSData, completion: JSONParserCompletion)
    {
        do {
            if let JSON = try NSJSONSerialization.JSONObjectWithData(self.JSONData(), options: .MutableContainers) as? [[String: AnyObject]] {
                var tweets = [Tweet]()
                for tweetJSON in JSON {
                    if let tweet = Tweet(json: tweetJSON) {
                        tweets.append(tweet)
                    }
                }
                completion(success: true, tweets: tweets)
            }

        } catch { completion(success: false, tweets: nil)}
    }
    
    class func JSONData() -> NSData
    {
        guard let tweetJSONPath = NSBundle.mainBundle().URLForResource("tweet", withExtension: "json") else {fatalError("tweet.json does not exist.")}
        
        guard let tweetJSONData = NSData(contentsOfURL: tweetJSONPath) else {fatalError("Failed to convert json to data.")}
        
        return tweetJSONData
    }
}