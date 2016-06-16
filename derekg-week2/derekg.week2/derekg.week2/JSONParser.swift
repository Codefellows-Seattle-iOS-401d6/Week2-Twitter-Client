//
//  JSONParser.swift
//  derekg.week2
//
//  Created by Derek Graham on 6/13/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

import Foundation
typealias JSONParserCompletion = (success: Bool, tweets : [Tweet]?) -> ()

class JSONParser
{
    class func tweetJSON(data: NSData, completion: JSONParserCompletion)
    {
        do {
            
            if let root_json_object = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [[ String : AnyObject]]{
                var tweets = [Tweet]()
                NSOperationQueue().addOperationWithBlock {
                    for tweetJson in root_json_object {
                        
                        if let tweet = Tweet(json : tweetJson)
                        {
                            tweets.append(tweet)
                        }
                    }
                    completion( success: true, tweets : tweets)
                }
            }
            
            
        }
        catch { completion(success: false, tweets : nil ) }
        
    }
    
    class func jsonData() -> NSData
    {
        guard let tweetJsonPath =
            NSBundle.mainBundle().URLForResource("tweet", withExtension: "json") else { fatalError("File does not exist: tweet.json")
        }
        
        guard let tweetJsonData = NSData(contentsOfURL : tweetJsonPath ) else {
            
            fatalError("unable to load json data")
        }
        return tweetJsonData
    }
    
}