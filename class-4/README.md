#Week 2 - Class 4
##Homework
* Lazily download the user profile images for each tweet you display.
* Implement a Simple Cache to check and see if an image you are about to download is already downloaded before doing a network call
* In your single tweet view controller:
	* Have an imageView that shows the user's profile image, if the tweet is a retweet, show the **original** User's profile image.
	* upon clicking on the person's image the app should push a 3rd view controller onto the stack
* This 3rd view controller will show that user's timeline (the api url is "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name" but you will need to add a parameter to this url.
* Convert your table view cells to use a Nib, so you can share the same cell for both the home time line VC and the user Timeline VC.

###Reading Assignment:

* Cracking the coding Interview/Programming Interviews Exposed:
  * Linked Lists

##Other Resources
* [Reading Assignments](../../Resources/ra-grading-standard/)
* [Grading Rubrics](../../Resources/)
* [Lecture Resources](lecture/)
* [Lecture Slides](https://www.icloud.com/keynote/000KMDpLPEkp73gzYutBM0RZQ#Week2_Day4)

~link lists (reversal, insert a node a specific index)
~big O!
~based on the app

LINK LISTS ARE
DATA STRUCTURES THAT HAVE A NODE that contains data AND A POINTER TO THE NEXT node

Double link list
Data structure has the node that contains data, has a pointer to the next and to the previous.

Insertions are O(n).  Typically, it is O(n) /2

NIBS, XIBS since XCODE, allowed developers to create interfaces graphically instead of programmatically.

Create a single isolated view controller layout.
Create the layout of a non-view controller related view.
Work with source control.
Work with interface objects, just like storyboards.

System loads content of the nib file into memory.
NIBs object graph is unarchived with NSKeyedUnarchiveer
All connections are re established (outlets and actions)
wakeFromNib()

UITableViewCell & XIBS

create xib filee
Drag a table view or collection view cell into your XIBS
Set the class of the cell to your custom class.
viewDidLoad(), or some other appropriate setup method, call registerNib:ForCellReuseIdentifier on your table view.
numberOfRowsInSection, cellForRowAtIndexPath

UITableViewHeaderView.. just a regular UIView.

Placed at the top or bottom of a table section, can be created programmatically or in interface builder.

Used for displaying additional information for section in focus.
UITableViewHeaderFooterView can be used without subclassing in most cases.
You can also implement tableView:titleForHeaderInSection to display a custom section title without needing ot use custom subviews.

UIImageAsset object is a container for a collection of images that represent multiple way sof describing a single piece of artowkr.

Used for grouping of multiple images of that same item at different display scales.
Supports image as Sets, App Icons, Launch images
When you drag an image into CXAsset, an image set will be created for you, you'll se 1x, 2x, and 3x slots for each image.
Image sets can be configured to be device or class specicic.

If you're using statically sized imgs and not vector images, you MUST have correctly sized img based on point size.  If you don't , the system has to rescale and greatly increases memory.

You can always check what screne you're working with with .......


based on waht the device of the scale, append @2x or @3x to the img to help xcode corretly manage the image

extention UIImageAsset{
	func resized(size: CGSize) -> UIImageAsset{
		UIGraphicsBeginImageContext(size)
		let newFrame = CGRect(x: 00, y: 0.0, width: size.width, height: size.height)
		self.drawinRect(newFrame)

		defer {
			UIGraphicsEndImageContext()
		}
		return UIGraphicsGetImageFromCurrentImageContext()
	}
}

#INTERVIEW QUESTION:
Write cache implementation.
...specify a custom size
Accessing the img makes it the most recent.

Return url to the data.

CREATEA Cache.swift in App Global

class Cache<T: Hashable>
{
	private var database: [String: T]
	private var transactions: [String]
	private let size: Int
	required init(size: Int)
	{
		self.database = Dictionary(minimumCapacity: size)
		self.transactions = [String]()
		self.size = size
	}

	func write(data: T, key: String)
	{
		if self.transactions.count < self.size {
			self.database[key] = data
			self.transactions.append(key)
		} else {
			let top = self.transactions.removeFirst()
		}
	}







	UserTimelineViewController: UIViewController, UITableViewDataSource {

		var tweet: Tweet?
		var tweets = [Tweet]() {
			didSet {
				self.tableView.reloadData()
			}
		}

		override func viewDidLoad() {
			super.viewdidload()

			setUpTableView()

			if let tweet = self.tweet, user = tweet.user {
				if let originalTweet = tweet.retweet, originalUser = originalTweet.user {
					self.navigationItem.title = originalUser.name 
					self.update(originalUser.screenName)
				} else {
					self.navigationItem.title = user.screenname
					self.update(user.screenName)
				}
			}

			func update(screenname: string)
			{
				API.shared.getUserTweets(screenname) { (tweets) in
				guard let tweets = tweets else {return}
				self.tweets = tweets

			}
			}

		}
	}

below didREceiveMemoryWarning....

GRAB AND COPY func setupTableView()

self.tableView.dataSource = self (replace 4th line delegate with this)

func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
{
	return self.tweets.count
}

tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
	let tweetCell = self.tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetCell
	tweetCell.tweet = self.tweets[indexPath.row]
	return tweetCell
}


IN DetailViewCOntroller
AFTER viewdidLoad
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
{
	if segue.identifier == UserTimelineViewController.id()
	{
		let UserTimelineViewController = segue.destinationViewController as! UserTimelineViewController
		UserTimelineViewController.tweet = self.tweet

	}
}
