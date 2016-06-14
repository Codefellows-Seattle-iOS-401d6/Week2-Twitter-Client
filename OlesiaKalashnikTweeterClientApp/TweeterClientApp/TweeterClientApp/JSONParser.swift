//
//  JSONParser.swift
//  TweeterClientApp
//
//  Created by Olesia Kalashnik on 6/13/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import Foundation

// typealias for completion
typealias NSJSONComplition = (successful: Bool, tweets: [Tweet]?) -> ()
class JSONParser {
    class func tweetJSONFrom(data: NSData, completion: NSJSONComplition) {
        do {
            let JSONArray = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [[String : AnyObject]]
            var tweets = [Tweet]()
            if let JSONArrayOfTweets = JSONArray {
                for tweetJSON in JSONArrayOfTweets {
                    if let tweet = Tweet(json: tweetJSON) {
                        tweets.append(tweet)
                        print(tweet.text)
                    }
                }
                completion(successful: true, tweets: tweets)
            }
        }
        catch {
            completion(successful: false, tweets: nil)
        }
    }
    
    class func JSONData() -> NSData {
        guard let tweetJSONURL = NSBundle.mainBundle().URLForResource("tweet", withExtension: "json") else {
            fatalError("Could not find tweet.json")
        }
        guard let tweetJSONData = NSData(contentsOfURL: tweetJSONURL) else {
            fatalError("Could not fetch tweets")
        }
        return tweetJSONData
    }
    
}