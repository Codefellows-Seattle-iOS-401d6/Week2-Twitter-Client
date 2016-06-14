#Week 2 - Class 2
##Homework
* Use the Accounts framework to access the user's twitter account on their iOS device
* Use the Social framework to make a request to twitter for the users home timeline
* Use the Social framework to make a request to twitter for logged in user and create your model User object
* Use a ranged switch statement to make sure the status code of the response is good
* Reload the table view on the main thread (aka main queue) once you are done parsing the JSON data from the response
* Show the downloaded tweets on your table view
* In your JSONParser, make sure to create each Tweet on a different Queue.
* **Bonus:**
	* Write your code to be able to handle multiple twitter accounts.(10 Points!!)

###Reading Assignment:
* Apple Documentation:
	* Accounts Framework
	* Social Framework
	* NSOperationQueue
* General Concepts:
	* Concurrency
	* HTTP Response Codes
* Swift Programming Guide:
	* Closures

##Other Resources
* [Reading Assignments](../../Resources/ra-grading-standard/)
* [Grading Rubrics](../../Resources/)
* [Lecture Resources](lecture/)
* [Lecture Slides](https://www.icloud.com/keynote/000uqYv8pF8GzEcQl1U3AEMqA#Week2_Day2)

--

LINKED LISTS!

node - data and next?
linkedlist have functions for adding/removing/printing/counting/insertion (contains head(pointer) and functions(insert, print, count))

#can linked lists be created with structures and classes?

ACCOUNTS FRAMEWORK!
Framwork provides access to user accounts stored in the accounts database.
Asking for a user's settings access.

Each acount stores credentiasl for a particular SErvice, like facebook or twitter.
By implementing the Accounts framework into your app, you do not need to be responsible for storing account logins yourlsef.
Currently, there are 4 service types available: Facebook, twitter, sinaweibo, tencentweibo

Get reference to account store by instantiating an instance of ACAccountStore

Get a reference to the corrent account type you're looking by calling accountTypeWithTypeIdentifier() on your account (twitter, facebook0

call requestAccessToAccountsWithType(completion:) on your account (this calls "this app needs to access your current settings")
Prompt the user, asking which account they would like to use (or pull object at index 0 from array assuming there's only one account)

Highly asynchronous!

CALLBACKS ARE PIECE OF EXECUTABLE CODE THAT IS PASSED AS ARGUMENT TO OTHER CODE, WHICH IS ExPECTED TO CALL BACK (EXECUTE) THE ARGUMENT AT SOME time

asynchronous callback - a callback that hpapens at a later time which is what social framework users
All of Apples networking APIs use asynchronous CALLBACKS
Very useful for perfoming expensive operations without blocking the main thread (where UI runs)

UI related bug - make sure calls are hapening on background thread, and implement own callbacks to the functions.

and/or make sure your UI isn't trying to update on the background thread.  Callbacks should return to the main thread, and the UI will update on the main thread.

--usually everything runs on the main thread, the exception is things that require time to respond.

SOCIAL framework provides simple interface for acecssing the user's socila media account.

Account framework gets into the account.  Social framework will make the request.

Prior to iOS6 there was only Twittter, iOS6 supports its new introduced  Social frameowkr, Facbeook, SinaWeibo, Tencent Weibo and Twitter.

Requests and composing.

SLRequest = make a request with social framework.
SLRequest is an easy way to configure and perform an actual HTTP request for one of the supported social services


SLRequest has an intializer that does most of the setup for you, once you request the setup,l you fire it off with
performRequestWithHandler()

twitter endpoints: GET account/verify_credentials

GET statuses/home_timeline



Concurrency
multiple things happening at the same time

Threads are a lightweight way to implement multiple paths of execution inside of an application.
Queues are wrappers around threads.
Each program can have multiple threads of execution
Threads are used to perofmr tasks simultaneously or allmost simultaenously.  In a single core CPU, multithreading can give teh appearance of multitasking into slices and running the slices from different tasks one after another.
Using multiple threads in your app allos more multi responsivieness


Each thread coordinates its action with other theads to prevent memory correuption.  If two threads are trying to read/write teh same data in your app at the same time, bad things hppane.
All iterface operations have to take place on the main thread.

NSOperationQueue is an API designed to abstract away adding operations to different threadsOperations are added t an operation queue so they can be EXECUTEd
Creating an operation queue is sas simple as callingl the init on NSOperationQueueu
You can add operations to a queue indivudally, in an array, or by simpling passing in a closure with the code you want to execute.

Concurrent queues can run more than one operation at once.
Serial queues can only run one operation at a timeThe main =queue is strictly a serial queueBy default, an NSOperationQueue you create is set to be Concurrent

HTTP STATUS CODES!

NSURLSession

----

new file iOS Source (Swifft) save as API (save under Utility) create.

import Accounts
import Social

class API: {
	//create a singleton of the account to have a static instance of the account so we don't have to constantly reauthenticate and resign in.

	static let shared = API() //singleton
	var account: ACAccount? //assumes the user may not have input account yet

	//4 functions: private login, private getOAuthUser, private updateTimeline, internal getTweet

	private func login(completion: (account: ACAccount?) -> ())
{
	let accountStore = ACAccountStore()

	let accountType = accountStore.accountTypeWithTypeIdentifier(ACAccountTypeIdentifierTwitter) //under the hood, it's a string that is now accountType

	accountStore.requestAccessToAccountsWithType(accountType, options: nil, completion:  {(granted, error) Void in
		if let _ = error{
			print("Error: Request access to accounts returned an error.")
			completion(account: nil)
			return
		}
		if granted {
			if let account = accountStore.accountsTypeWitHAccountTypeIdentifier(accountType).first as? ACAccount {
				completion(account: account)
				return
			}
			print("ERROR! No twitter found on this device!")
			completion(account: nil)
			return
		}
		print("Error; this app requires access to twitter accounts!")
		completion(account: nil)
		return
	})
}

private func GETOAuthUser(completion: (user: User?) -> ())
{
	let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/account/verityf-credentials.json"), paramters: nil)

	request.account = self.account
	request.performRequestWithHandler { (data, response, error) in
		if let _ = error{
			print("Error!  SLRequest type get for credentials could not be completed.")
			completion(user: nil)
			return
		}
		switch response.statusCode {
			case 200...299:
			do {
				if let userJSON = try NSJSONSerialization.JSONObjectWithdata(data, options: .MutableContainers) as [String : AnyObject] {
					completion(user: User(json: userJSON))

				}
			} catch {
					print("error! could not serialize the JSON!")
					completion(user: nil)
			}

			case 400...499:
			print("client error \(response.statusCode)")
			completion(user: nil)

			case 500...599:
			print("server error \(response.statusCode)")
			completion(user: nil)

			default:
				print("default case on the status code")
				completion(user: nil)

		}
	}
}

private func updateTimeline(completion: (tweets: [Tweet]? -> ())) {
	let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json"), parameters: nil)
	request.account = self.account
	request.performRequestWithHandler {(data, response, error) in
		if let _ = error {
			print("error")
			completion(tweets: nil)
			return
		}
		switch response.statusCode {

			case 200...299:

			JSONParser.tweetJSONFRom(data, completion: {(success, tweets) in
				dispatch_async(dispatch_get_main_queue(), {
					completion(tweets: tweets)
					})
				})

			case 400...499:
			default("default")
			completion(tweets: nil)
			case 500...599:
			default("default")
			completion(tweets: nil)
			default:
			print("default")
			completion(user: nil)
		}
	}
}

func getTweets(completion: (tweets: [Tweet]?) -> ()) {
	if let _ = self.account {
		self.updateTimeline(completion)
			} else {
				self.login({(account) in
					if let account = account{
						API.shared.account = account
						self.updateTimeline(completion)
					}
					else {
						print("account is nil.  oops.")
					}
					})
			}
	}
}

INSIDE VIEWCONTROLLER.SWIFT!
//this goes between override funcviewWillApepar and override func didReceiveMemoryWarning & extension

func update() {
	API.shared.getTweets { (tweets) in
	if let tweets = tweets{
		self.datasource = tweets
		}}
}

replace JSONParser.tweetJSONFrom(JSON) blah blah if let self.datasource in override func viewWillApepar with self.update()

BONUS!  GO BACK TO .first area and investigate.
