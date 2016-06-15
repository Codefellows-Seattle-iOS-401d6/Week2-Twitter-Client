//
//  JSONParser.swift
//  TWTR
//
//  Created by Sean Champagne on 6/13/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

import Foundation

typealias JSONParserCompletion = (success: Bool, tweets: [Tweet]?) -> ()

class JSONParser
{
    class func tweetJSONFrom(let data: NSData, completion: JSONParserCompletion)
    {
        do {
            
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [[String: AnyObject]] {
                
            var tweets = [Tweet]()
            for tweetJSON in rootObject {
                if let tweet = Tweet(json: tweetJSON)
                {
                    tweets.append(tweet)
                }
                }
                completion(success: true, tweets: tweets)
        }
        }
    catch {
        completion(success: false, tweets: nil)
    }
}

class func JSONData() -> NSData
{
    guard let tweetJSONPath = NSBundle.mainBundle().URLForResource("twitter", withExtension: "json") else {
        fatalError("tweet.json does not exist.  Sorry!")
    }
    guard let tweetJSONData = NSData(contentsOfURL: tweetJSONPath) else {fatalError("Failed to convert JSON data")}
    return tweetJSONData
}
}