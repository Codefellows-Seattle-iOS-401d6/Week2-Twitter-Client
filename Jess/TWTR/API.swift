//
//  API.swift
//  TWTR
//
//  Created by Jess Malesh on 6/14/16.
//  Copyright © 2016 Michael Babiy. All rights reserved.
//

import Foundation
import Accounts
import Social

class API { //creat as sigleton for static instance of account
    
    static let shared = API()
    
    var account: ACAccount? //where we store account into
    
    //four functions 
    
    private func login(completion: (account: ACAccount?) -> ())
    {
        let accountStore = ACAccountStore()
        
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) in
            
            
            if let _ = error{
                print("Error: Request access to account returned an error")
                
                completion(account: nil)
                return
            }
            
            if granted{
                
                if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount
                {
                    completion(account: account)
                    return
                }
                
                print("Error: No twitter accounts found on this device")
                completion(account: nil)
                
            }
            print("error: this app requires access to Twitter Accounts")
            completion(account: nil)
            
        }
    }
    
    func GETOAuthUser(completion: (user: User?) -> ())
    {
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json"), parameters: nil)
        
        request.account = self.account
        
        request.performRequestWithHandler { (data, response, error) in
            if let _ = error{
                print("Error: SLRequest type get for credentials could not be complete")
                completion(user: nil)
                return
            }
            
            switch response.statusCode{
            case 200...299:
                do {
                    if let userJSON = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String : AnyObject]{
                        completion(user: User(json: userJSON))
                    }
                } catch {
                    print("Error: Count not serialized the JSON")
                    completion(user: nil)
                }
                
                
            case 400...499:
                print("Client error stastuscode: \(response.statusCode)")
                completion(user: nil)
            case 500...599:
                print("Client error stastuscode: \(response.statusCode)")
                completion(user: nil)
                
                
                
            default:
                print("Default case on the status code")
            }
        }
        
    }
    
    
    //get our tweets
    private func updateTimeLine(urlString: String, completion: (tweets: [Tweet]?) -> ())
    {
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL(string: urlString), parameters: nil)
        
        request.account = self.account
        
        request.performRequestWithHandler { (data, response, error) in
            
            if let _ = error{
                print("Error: SLRequest type get user Timeline could not be completed")
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
                print("Client error stastuscode: \(response.statusCode)")
                completion(tweets: nil)
                
            case 500...599:
                print("Client error stastuscode: \(response.statusCode)")
                completion(tweets: nil)
                
            default:
                print("Default case on the status code")
                completion(tweets: nil)
            }
            
            
        }
    }
    
    //public methods that handles 3 privates to be called in VC
    
    
    
    
    
    
    func getTweets(completion: (tweets: [Tweet]?) -> ())
    {
        if let _ = self.account{
//            self.updateTimeLine(completion)
            self.updateTimeLine("https://api.twitter.com/1.1/statuses/home_timeline.json", completion: completion)
        }
        else {
            self.login { (account) in
                if let account = account{
                    API.shared.account = account
//                    self.updateTimeLine(completion)
                    self.updateTimeLine("https://api.twitter.com/1.1/statuses/home_timeline.json", completion: completion)
                }
                else {
                    print("Account is nil")
                }
            }
        }
    }
    
    func getUserTweets(userName: String, completion: (tweets: [Tweet]?) -> ())
    {
        self.updateTimeLine("https://api.twitter.com/1.1/statuses/home_timeline.json?screen_name=\(userName)", completion: completion)
    }
    
    func getImage(urlString: String, completion:(image: UIImage)->())
    {
        
        NSOperationQueue().addOperationWithBlock
        {
            guard let url = NSURL(string: urlString) else { return }
            guard let data = NSData(contentsOfURL: url) else { return }
            guard let image = UIImage(data: data) else { return }
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                completion(image: image)
            })
        }
    }
}





























