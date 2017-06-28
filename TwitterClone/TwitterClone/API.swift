//
//  API.swift
//  TwitterClone
//
//  Created by Jeremy Moore on 6/14/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//
import Foundation
import Social
import Accounts

class API {
    
    static let shared = API()
    
    var account: ACAccount?
    
    func login(completion: (account: ACAccount?) -> ()) {
        let accountStore = ACAccountStore()
    
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
            if let _ = error{
                print("Error: Request access to account returned an error. ")
                completion(account: nil)
                return
            }
            if granted{
                if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
                    completion(account: account)
                    return
                }
                //No account found
                print("Error, no twitter accounts found")
                completion(account: nil)
                return
            }
            //not granted
            print("Error, no twitter accounts found")
            completion(account: nil)
            return
        }
    }
    
    private func GETOAuthUsser(completion: (user: User?) ->()) {
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json"), parameters: nil)
        
            request.account = self.account
        
            request.performRequestWithHandler {(data, response, error) in
            if let _ = error{
                print("Error: SLReuest type get for credentials failed")
                completion(user: nil)
                }
            
            switch response.statusCode{
            case 200...299:
                do {
                    if let userJSON = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String: AnyObject] {
                        completion(user: User(json: userJSON))
                    }
                } catch {
                    print("Error: Could not serialize JSON")
                    completion(user: nil)
                }
                
            case 400...499:
                print("Client Error statuscode \(response.statusCode)")
                completion(user: nil)
            case 500...599:
                print("Server Error statuscode \(response.statusCode)")
                
            default:
                print("default case on status code \(response.statusCode)")
                completion(user: nil)
                
            }
        }
    }
    
    private func updateTimeline(completion: (tweets: [Tweet]?) -> ()) {
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json"), parameters: nil)
        
            request.account = self.account
        
            request.performRequestWithHandler { (data, response, error) in
                if let _ = error{
                    print("Error: SLReuest for user timeline failed")
                    completion(tweets: nil)
                    return
                }
            switch response.statusCode{
                case 200...299:
                    JSONParser.tweetJSONFrom(data, completion: { (success, tweets) in
                        dispatch_async(dispatch_get_main_queue(), {
                            completion(tweets: tweets)
                        })
                    })
                
            case 400...499:
                print("Client Error statuscode \(response.statusCode)")
                completion(tweets: nil)
            case 500...599:
                print("Server Error statuscode \(response.statusCode)")
                
            default:
                print("default case on status code \(response.statusCode)")
                completion(tweets: nil)
                
            }
            
        }
    }
    func getTweets(completion: (tweets: [Tweet]?) -> ()) {
        if let _ = self.account{
            self.updateTimeline(completion)
        } else {
            self.login( {(account) in 
                if let account = account{
                    API.shared.account = account
                    self.updateTimeline(completion)
                } else {
                    print("Account is nil")
                }
            })
        }
    }
}