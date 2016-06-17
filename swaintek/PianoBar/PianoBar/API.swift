//
//  API.swift
//  PianoBar
//
//  Created by David Swaintek on 6/15/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

import Foundation
import Accounts
import Social

class API {
    
    static let shared = API()
    
    var account: ACAccount?
    
    func login(completion: (account: ACAccount?) -> ())
    {
        //Account Store
        let accountStore = ACAccountStore()
    
        //Give account store an account type
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier (ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil,
            completion: {(granted, error) -> Void in
                
                if let _ = error {
                    print(error.localizedDescription)
                    completion(account: nil)
                    return
                }
                
                if granted {
                    if let accounts =
                        accountStore.accountsWithAccountType(accountType).first as? ACAccount {
                        dispatch_async (dispatch_get_main_queue(), {
                            completion(account: accounts)
                            return
                        })
                    }
                    
                    //When no account is found
                    print("ERROR: No twitter accounts were found on this device.")
                    completion(account: nil)
                    return
                }
                
                //If user does not grant access
                print("ERROR: This app requires access to the Twitter Accounts.")
                completion(account: nil)
                return
        })
    }
    
    func GETOAuthUser(completion: (user: User?) -> ()) {
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                requestMethod: .GET, URL: NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json"), parameters: nil)
        
        request.account = self.account
        
        request.performRequestWithHandler { (data, response, error) in
            
            if let _ = error{
                print("ERROR: SLRequest type get for credentials could not be completed")
                completion(user: nil)
                return
            }
            
            switch response.statusCode{
            case 200...299:
                do {
                    if let userJSON = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String: AnyObject]{completion(user: User(json: userJSON))
                    }
                } catch {
                    print("ERROR: Count not serialize the JSON")
                    completion(user:nil)
                }
            case 400...499:
                print("Client ERROR status code: \(response.statusCode)")
                completion(user:nil)
            case 500...599:
                print("Server ERROR status code: \(response.statusCode)")
                completion(user:nil)
            default:
                print("Default case on the status code")
                completion(user:nil)
            }
        }
    }

    private func updateTimeline(completion: (tweets: [Tweet]?) -> ()){
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL(
            string:"https://api.twitter.com/1.1/statuses/home_timeline.json"), parameters: nil)
        
        request.account = self.account
        
        request.performRequestWithHandler {(data, response, error) in
            if let _ = error {
                print("ERROR: SLRequest type get for user Timeline could not be completed")
                completion(tweets: nil)
                return
            }
            
            switch response.statusCode{
                
            case 200...299:
                JSONParser.tweetJSONFrom(data, completion: {(success, tweets) in
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(tweets: tweets)
                    })
                })
            case 400...499:
                print("Client Error status code: \(response.statusCode)")
                completion(tweets: nil)
            case 500...599:
                print("Default case on the status code")
                completion(tweets: nil)
            default:
                print("Default case on the status code")
                completion(tweets: nil)
            }
        }
    }

    func getTweets(completion: (tweets: [Tweet]?) -> ()){
        
        if let _ = self.account{
            self.updateTimeline(completion)
        }
        
        else {
            self.login({ (account) in
                if let account = account {
                    API.shared.account = account
                    self.updateTimeline(completion)
                }
                
            })
        }
    }
}




















































