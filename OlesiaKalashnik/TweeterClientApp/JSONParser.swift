//
//  JSONParser.swift
//  TweeterClientApp
//
//  Created by Olesia Kalashnik on 6/13/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import Foundation

typealias NSJSONComplition = (successful: Bool, tweets: [Tweet]?) -> ()
class JSONParser {
    class func tweetJSONFrom(data: NSData, completion: NSJSONComplition) {
        do {
            let JSONArray = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [[String : AnyObject]]
            var tweets = [Tweet]()
            
            // Create tweets on a separate queue
            let opQueue = NSOperationQueue()
            opQueue.addOperationWithBlock({
                
                if let JSONArrayOfTweets = JSONArray {
                    for tweetJSON in JSONArrayOfTweets {
                        if let tweet = Tweet(json: tweetJSON) {
                            tweets.append(tweet)
                        }
                    }
                    //Complition will be handed over to the main queue in API updateTimeline function
                    completion(successful: true, tweets: tweets)
                }
            })
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