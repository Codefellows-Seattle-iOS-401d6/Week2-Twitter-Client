//
//  API.swift
//  TweeterClientApp
//
//  Created by Olesia Kalashnik on 6/14/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import Foundation
import Accounts
import Social

public class API {
    //API is going to be a singleton
    private init() {}
    static let shared = API()
    var allAccounts : [ACAccount]?
    var account : ACAccount?
    
    
    //1. Try to login into accounts
    private func login(completion: (account: ACAccount?) -> () ) {
        let accStore = ACAccountStore()
        let accType = accStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accStore.requestAccessToAccountsWithType(accType, options: nil) { (accessGranted, error) in
            //error handling, pass nil to completion
            if let _ = error {
                completion(account: nil)
                print("Error: Received an error when requested access to accounts")
                return
            }
            //if access to accounts was granted, get the 1st account and pass it to completion
            if accessGranted {
                if let accounts = accStore.accountsWithAccountType(accType) as? [ACAccount] {
                    for accs in accounts {
                        print(accs.userFullName)
                    }
                    self.allAccounts = accounts
                    completion(account: accounts.first)
                    return
                }
            }
            //if access to accounts wasn't granted, pass nil to completion
            print("Error: App cannot access account")
            completion(account: nil)
            return
        }
    }
    
    //2. Get verified Twitter user
    func GETAuthorizedUser(completion: (user: User?) -> ()) {
        //create an HTTP request
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json"), parameters: nil)
        //send a request to Twitter to retrieve user
        request.performRequestWithHandler { (data, response, error) in
            if let _ = error {
                print("Error: Request for credentials couldn't be completed")
                completion(user: nil)
                return
            }
            
            switch response.statusCode {
            case 200..<300:
                //User object can be created via JSONSerialization
                do {
                    if let userJSON = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String:AnyObject] {
                        let user = User(json: userJSON)
                        completion(user: user)
                    }
                }
                catch {
                    print("JSON for user could not be serialized")
                }
            //User object can't be created
            case 400..<500:
                completion(user: nil)
                print("Client error: statusCode \(response.statusCode).")
            case 500..<600:
                completion(user: nil)
                print("Server error: statusCode \(response.statusCode).")
            default: print("Default case for statusCode.")
            }
        }
    }
    
    //3. Update user's timeline
    private func updateTimeline(completion: (tweets: [Tweet]?)->()) {
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json"), parameters: nil)
        
        request.account = self.account
        
        //send a request to Twitter to retrieve user
        request.performRequestWithHandler { (data, response, error) in
            if let _ = error {
                print("Error: Request for timeline update could not be completed")
                completion(tweets: nil)
                return
            }
            
            switch response.statusCode {
            case 200..<300:
                //User object can be created via JSONSerialization
                JSONParser.tweetJSONFrom(data) { (successful, tweets) in
                    //return tweets to the main queue from opQueue
                    dispatch_async(dispatch_get_main_queue()) { completion(tweets: tweets) }
                }
            //User object can't be created
            case 400..<500:
                completion(tweets: nil)
                print("Client error: statusCode \(response.statusCode).")
            case 500..<600:
                completion(tweets: nil)
                print("Server error: statusCode \(response.statusCode).")
            default: print("Default case for statusCode.")
            }
        }
    }
    
    //4. API's interface for fetching tweets
    func fetchTweets(completion: (tweets:[Tweet]?) -> ()) {
        //Case when account has been setup
        if let _ = self.account {
            updateTimeline(completion)
        } else {
            //Setup each account and update timelines
            self.login({ (account) in
                if let acc = account {
                    API.shared.account = acc
                    self.updateTimeline(completion)
                } else {
                    print("Could not login")
                }
            })
        }
    }
    
}
