//
//  TwitterAPI.swift
//  derekg.week2
//
//  Created by Derek Graham on 6/14/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

import Foundation

import Accounts
import Social

class API
{
    static let shared = API()
    
    var account: ACAccount?
    var accountStore: ACAccountStore?
    var accountID: String?
    
    func getAccountStore(completion: (accountStore: ACAccountStore?) ->())
    {
        let accountStore  = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) {(granted, error) in
            
            if let _ = error {
                print("Error: Request Access To Accounts error.")
                completion(accountStore: nil)
                return
            }
            
            if granted {
                if accountStore.accounts.count > 1 {
                    completion( accountStore: accountStore)
                    return
     
                }
  
                print("Error getting account store")
                completion(accountStore: nil)
                return
            }
            
            
        }
        print("Error requesting access error")
        completion(accountStore: nil)
        return
        
        
    }

    private func login(completion: (account: ACAccount?) ->())
    {
        let accountStore  = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) {(granted, error) in
            
            if let _ = error {
                print("Error: Request Access To Accounts error.")
                completion(account: nil)
                return
            }
            
            if granted {
                
                if let account = accountStore.accountsWithAccountType(accountType).first as?
                    ACAccount {
                    print(accountStore.accounts)
                    completion( account: account)
                    return
                }
                
                print("Error getting first account from account store")
                completion(account: nil)
                return
            }
            
            
        }
        print("Error requesting access error")
        completion(account: nil)
        return
        
    }
    
    
    private func loginWithIdentifier(identifier: String, completion: (account: ACAccount?) ->())
    {
        let accountStore  = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) {(granted, error) in
            
            if let _ = error {
                print("Error: Request Access To Accounts error.")
                completion(account: nil)
                return
            }
            
            if granted {
                
                if let account = accountStore.accountWithIdentifier(identifier) as
                    ACAccount? {
                    completion( account: account)
                    return
                }
                
                print("Error getting first account from account store")
                completion(account: nil)
                return
            }
        
        
        }
        print("Error requesting access error")
        completion(account: nil)
        return
        
        
    }
    
    func GETOAuthUser(completion: (user: User?) -> ()){
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                requestMethod: .GET,
                                URL: NSURL (string: "https://api.twitter.com/1.1/account/verify_credentials.json") ,
                                parameters: nil)
        
        
        request.account = self.account
        request.performRequestWithHandler( { (data, response, error) -> () in
            if let _ = error {
                print("SLRequest could not be completed")
                completion(user: nil)
                return
            }
            
            switch response.statusCode {
            case 200...299:
                do {
                    if let userJSON = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String : AnyObject] {
                         dispatch_async(dispatch_get_main_queue(), { completion(user: User(json: userJSON))
                    })
                    }
                    
                }
                catch {
                    print("error with serialization")
                    completion( user: nil)
                }
                
            case 400...499:
                print("Client Error \(response.statusCode)")
                completion(user: nil)
                
            
            case 500...599:
                print("Server Error \(response.statusCode)")
                completion(user: nil)
            
            default:
                print("GET default error \(response.statusCode)")
                completion(user: nil)
                
            }
            return
        })
        
    }
    
    private func updateTimeLine( completion: (tweets: [Tweet]?) -> ()){
        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                requestMethod: .GET,
                                URL: NSURL (string: "https://api.twitter.com/1.1/statuses/home_timeline.json"),
                                parameters: nil)
        
        request.account = self.account
        
        request.performRequestWithHandler( { (data, response, error) -> () in
            if let _ = error {
                print("SLRequest error \(response.statusCode)")
                completion(tweets : nil)
                return
            }
            
            switch response.statusCode{
            case 200...299:
                JSONParser.tweetJSON(data, completion: { (success, tweets) in
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(tweets: tweets)
                    })
                    
                })
            case 400...499:
                print("Client Error \(response.statusCode)")
                completion(tweets: nil)
            case 500...599:
                print("Server Error \(response.statusCode)")
                completion(tweets: nil)
            default:
                print("GET home time line default error \(response.statusCode)")
                completion(tweets: nil)
            }
        })
 
    }
    
    
    func getTweets( completion:  ( tweets: [Tweet]? ) -> ()){
        
        if let _ = self.accountStore {
            
            if let _ = self.accountID {
                self.updateTimeLine(completion)
            } else {
                self.loginWithIdentifier(self.accountID!, completion: { (account) in
                    if let account = account {
                        API.shared.account = account
                        self.updateTimeLine(completion)
                    } else {
                        print("unable to login to account with ID")
                    }
                })
            }
            
        
        } else {
            
            if let _ = self.account {
                self.updateTimeLine(completion)
            } else {
                
                self.login( { (account) in
                    if let account = account {
                        API.shared.account = account
                        self.updateTimeLine(completion)
                    } else {
                        print("account is nil")
                    }
                    
                })
                
            }

        }

        

    }
    
    
}