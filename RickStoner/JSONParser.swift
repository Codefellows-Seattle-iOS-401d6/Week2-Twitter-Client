//
//  JSONParser.swift
//  TWTR
//
//  Created by Rick  on 6/13/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import Foundation

typealias JSONParserCompletion = (success: Bool, tweets: [Tweet]?) -> ()

class JSONParser {
    
    class func tweetJSONFrom(data: NSData, completion: JSONParserCompletion) {
        do {
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [[String : AnyObject]] {
                
                var tweets = [Tweet]()
                
                for JSONTweet in rootObject {
                    if let tweet = Tweet(json: JSONTweet) {
                        tweets.append(tweet)
                    } else {
                        print("Nil")
                    }
                    
                    completion(success: true, tweets: tweets)
                }
                
            }
        } catch {
            completion(success: false, tweets: nil)
        }
    }
    
    class func JSONData () -> NSData {
        guard let tweetJSONPath = NSBundle.mainBundle().URLForResource("tweet", withExtension: "json") else {
            fatalError("Did not recognize JSON file name")
        }
        guard let tweetJSONData = NSData(contentsOfURL: tweetJSONPath) else {
            fatalError("No data found for file path")
        }
        return tweetJSONData
    }
    
}
