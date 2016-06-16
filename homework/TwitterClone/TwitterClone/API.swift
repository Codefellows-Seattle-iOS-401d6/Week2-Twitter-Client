//
//  API.swift
//  TwitterClone
//
//  Created by Sung Kim on 6/14/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import Foundation
import Accounts
import Social

class API
{
    static let shared = API()
    var account: ACAccount?
    
    func login(completion: (accounts: [ACAccount]?) -> ())
    {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil, completion: { (granted, error) -> Void in
            if let _ = error{
                print("Error: Request access to accounts returned an error.")
                completion(accounts: nil)
                return
            }
            
            if granted{
                if let accountsArray = accountStore.accountsWithAccountType(accountType) as? [ACAccount] {
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(accounts: accountsArray)
                        return
                    })
                }
            } else {
                print("Error: There are no Twitter accounts.")
                completion(accounts: nil)
                return
            }
//            print("Error: This app requires access to the Twitter Accounts.")
//            completion(accounts: nil)
//            return
        })
    }
    
    func GETOAuthoUser(completion: (user: User?) -> ())
    {
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json"), parameters: nil)
        
        request.account = self.account
        
        request.performRequestWithHandler { (data, response, error) in
            if let _ = error{
                print("Error: SLRequest type get for credentials could not be completed.")
                completion(user: nil)
                return
            }
            
            switch response.statusCode{
            case 200...299:
                do {
                    if let userJSON = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String : AnyObject] {
                        completion(user: User(json: userJSON))
                    }
                } catch {
                    print("Error: Could not serialize the JSON")
                    completion(user: nil)
                }
            case 400...499:
                print("Client Error statuscode \(response.statusCode)")
                completion(user: nil)
            case 500...599:
                print("Server Error statuscode \(response.statusCode)")
                completion(user: nil)
            default:
                print("Default case on the statuscode \(response.statusCode)")
                completion(user: nil)
            }
        }
    }
    
    private func updateTimeLine(completion: (tweets: [Tweet]?) -> ())
    {
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json"), parameters: nil)
        
        request.account = self.account
        
        request.performRequestWithHandler {(data, response, error) in
            
            if let _ = error{
                print("Error: SLRequest type get for Timeline could not be completed.")
                completion(tweets: nil)
            }
            
            switch response.statusCode{
            case 200...299:
                JSONParser.tweetJSONFrom(data, completion: {(success, tweets) in
                    if success {
                        dispatch_async(dispatch_get_main_queue(), {
                            completion(tweets: tweets)
                        })
                    } else {
                        print("JSON was not serialized")
                    }
                })
            case 400...499:
                print("Client Error statuscode \(response.statusCode)")
                completion(tweets: nil)
            case 500...599:
                print("Server Error statuscode \(response.statusCode)")
            default:
                print("Default case on the statuscode \(response.statusCode)")
                completion(tweets: nil)
            }
        }
    }
    
    func getTweets(completion: (tweets: [Tweet]?) -> ())
    {
        self.updateTimeLine(completion)
    }
}