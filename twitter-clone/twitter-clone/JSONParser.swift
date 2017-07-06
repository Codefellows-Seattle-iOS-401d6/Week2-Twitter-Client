//
//  JSONParser.swift
//  twitter-clone
//
//  Created by David Livingstone on 6/13/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import Foundation

typealias JSONParserCompletion = (success: Bool, tweets: [Tweet]?) -> ()

class JSONParser {
    class func tweetJSONFrom(data: NSData, completion: JSONParserCompletion) {
        do {
            if let root = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [[String: AnyObject]] {
                var tweets = [Tweet]()
                
                for tweetJSON in root {
                    if let tweet = Tweet(json: tweetJSON) {
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
    class func JSONData() -> NSData {
        guard let tweetJSONPath = NSBundle.mainBundle().URLForResource("tweet", withExtension: "json") else { fatalError("JSON does not exist") }
        guard let tweetJSONData = NSData(contentsOfURL: tweetJSONPath) else { fatalError("Failed to convert JSON data") }
        return tweetJSONData
    }
}