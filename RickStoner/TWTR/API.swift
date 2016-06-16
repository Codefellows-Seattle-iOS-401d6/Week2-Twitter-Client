//
//  API.swift
//  TWTR
//
//  Created by Rick  on 6/14/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import Foundation
import Accounts
import Social

class API {
    
    static let shared = API()
    
    var account: ACAccount?
    
    private func login(completion: (account: ACAccount?) ->()) {
        let accountStore = ACAccountStore()
        
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) in
            
            if let _ = error {
                print("Error: Access to account returned error")
                completion(account: nil)
                return
            }
            
            if granted {
                if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
                    completion(account: account)
                    return
                }
                
                print("Error, user rejected access")
                completion(account: nil)
                return
            }
        }
    }
    
    func GETOAuthUser(completion: (user: User?) -> ()) {
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json"), parameters: nil)
        
        request.account = self.account
        
        request.performRequestWithHandler { (data, response, error) in
            if let _ = error {
                print("Error, couldn't get credentials")
                completion(user: nil)
                return
            }
            
            switch response.statusCode {
            case 200...299:
                print("Great Success on OAuth response")
                do {
                    
                    if let userJSON = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String : AnyObject] {
                        completion(user: User(json: userJSON))
                    }
                } catch {
                        print("No JSON data returned from successful request")
                        completion(user: nil)
                    
                    }
            case 400...499:
                print("Client Error status code: ", response.statusCode)
                completion(user: nil)
            case 500...599:
                print("Server Error status code: ", response.statusCode)
                completion(user: nil)
            default:
                print("Reponse status code: ", response.statusCode, " Good Luck!")
                completion(user: nil)
            }
        }
    }
    
    private func updateTimeLine(urlString: String, completion: (tweets: [Tweet]?) -> ()) {
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL(string: urlString), parameters: nil)
        
        request.account = self.account
        
        request.performRequestWithHandler{ (data, response, error) in
            if let _ = error {
                print("Error, couldn't get credentials")
                completion(tweets: nil)
                return
            }
            
            switch response.statusCode {
            case 200...299:
                print("Great Success on timeline response")
                JSONParser.tweetJSONFrom(data, completion: { (succes, tweets) in
                    dispatch_async(dispatch_get_main_queue(), {
                            completion(tweets: tweets)
                        })
                })
            case 400...499:
                print("Client Error status code: ", response.statusCode)
                completion(tweets: nil)
            case 500...599:
                print("Server Error status code: ", response.statusCode)
                completion(tweets: nil)
            default:
                print("Reponse status code: ", response.statusCode, " Good Luck!")
                completion(tweets: nil)
            }
        }
    }
    
    func getTweets(completion: (tweets: [Tweet]?) -> ()) {
        if let _ = self.account {
            self.updateTimeLine("https://api.twitter.com/1.1/statuses/home_timeline.json", completion: completion)
        } else {
            
            self.login{ (account) -> () in
                if let account = account {
                    API.shared.account = account
                    self.updateTimeLine("https://api.twitter.com/1.1/statuses/home_timeline.json", completion: completion)
                } else {
                    print("Account is nil")
                }
            }
        }
    }
    
    func getUserTweets(username: String, completion: (tweets: [Tweet]?) -> ()) {
        self.updateTimeLine("https://api.twitter.com/1.1/statuses/home_timeline.json?screen_name=\(username)", completion: completion)
    }
    
    func getImage(urlString: String, completion: (image: UIImage) -> ()) {
        
        NSOperationQueue().addOperationWithBlock {
            
            guard let url = NSURL(string: urlString) else { return }
            guard let data = NSData(contentsOfURL: url) else { return }
            guard let image = UIImage(data: data) else { return }
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                completion(image: image)
            })
        }
    }
    
}
