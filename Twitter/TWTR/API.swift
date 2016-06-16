//
//  API.swift
//  TWTR
//
//  Created by Sean Champagne on 6/15/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

import Foundation
import Accounts
import Social

class API {
    //singleton creation
    static let shared = API()
    var account: ACAccount?
    
    //login function
    func login(completion: (account: ACAccount?) -> ())
    {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil, completion: {(granted, error) -> Void in
            if let _ = error {
                print("Error! Request access to accounts returned an error.  Lo siento.")
                completion(account: nil)
                return
            }
            if granted {
                if let account = accountStore.accountsWithAccountType(accountType).first as?
                    ACAccount {
                    completion(account: account)
                    return
                }
                print("Error!  No Twitter found on this device.")
                completion(account: nil)
                return
            }
            print("Error!  This app requires access to Twitter!")
            completion(account: nil)
            return
        })
    }
    //getOAuthUser function
    func GETOAuthUser(completion: (user: User?) -> ())
    {
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json"), parameters: nil)
        request.account = self.account
        request.performRequestWithHandler {(data, response, error) in
            if let _ = error {
                print("Error! SLRequest type GET for credentials could not be completed.")
                completion(user: nil)
                return
            }
            switch response.statusCode {
                
            case 200...299:
                do {
                    if let userJSON = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String : AnyObject] {
                        completion(user: User(json: userJSON))
                    }
                } catch {
                    print("Error! Could not serialize JSON data!")
                    completion(user: nil)
                }
                
            case 400...499:
                print("Client error:  \(response.statusCode)")
                completion(user: nil)
                
            case 500...599:
                print("Server error:  \(response.statusCode)")
                completion(user: nil)
                
            default:
                print("Default case on the status code.")
                completion(user: nil)
            }
        }
    }
    //update timeline function
    private func updateTimeline(urlString: String, completion: (tweets: [Tweet]?) -> ()) {
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL(string: urlString), parameters: nil)
        request.account = self.account
        request.performRequestWithHandler {(data, response, error) in
            if let _ = error {
                print("eeeeerror!")
                completion(tweets: nil)
                return
            }
            switch response.statusCode {
                
            case 200...299:
                JSONParser.tweetJSONFrom(data, completion: {(success, tweets) in
                    dispatch_async(dispatch_get_main_queue(), {completion(tweets: tweets)
                })
                })
                
            case 400...499:
                print("Client error:  \(response.statusCode)")
                completion(tweets: nil)
                
            case 500...599:
                print("Server error:  \(response.statusCode)")
                completion(tweets: nil)
                
            default:
                print("Default case on the status code.")
                completion(tweets: nil)
            }
        }
    }
    func getTweets(completion: (tweets: [Tweet]?) -> ()) {
        if let _ = self.account {
            NSOperationQueue.mainQueue().addOperationWithBlock( {
            self.updateTimeline("https://api.twitter.com/1.1/statuses/home_timeline.json", completion: completion)
            })
        } else {
            self.login({(account) -> () in
                if let account = account{
                    API.shared.account = account
                    NSOperationQueue.mainQueue().addOperationWithBlock( {
                    self.updateTimeline("https://api.twitter.com/1.1/statuses/home_timeline.json", completion: completion)
                    })
                } else {
                    print("error nil derp!")
                }
            })
        }
    }
    
    func getUserTweets(username: String, completion: (tweets: [Tweet]?) -> ())
    {
        self.updateTimeline("https://api.twitter.com/1.1/statuses/home_timeline.json?screen_name=\(username)", completion: completion)
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
