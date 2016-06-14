#Week 2 - Class 1
##Homework
* Create your MVC groups
* Create your Tweet class
* Create your User class
* Create your TweetJSONParser class
* Add text & id properties to your Tweet class
* Add properties for the username, and profileImageURL(all string types) to your User class
* Parse the JSON file into tweets, make sure all properties on each tweet are being set.
* Display those tweet objects in the table view, just the text for the tweet is fine today
* **Code Challenge:**
	* Write a function that reverses an array

###Reading Assignment:
* General Concepts:
  * [MVC](https://developer.apple.com/library/ios/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html)
* Apple Documentation:
  * [NSJSONSerialization](https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSJSONSerialization_Class/index.html)
  * [NSBundle](https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSBundle_Class/index.html)
  * [UITableView](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITableView_Class/index.html)

##Other Resources
* [Reading Assignments](../../Resources/ra-grading-standard/)
* [Reading Assignments](../../Resources/ra-grading-standard/)
* [Grading Rubrics](../../Resources/)
* [Lecture Resources](lecture/)
* [Lecture Slides](https://www.icloud.com/keynote/000JOeuDHWuUbUJrSdhFhQJcg#Week2_Day1)


#Week 2 - Class 1
##Homework
* Create your MVC groups
* Create your Tweet class
* Create your User class
* Create your TweetJSONParser class
* Add text & id properties to your Tweet class
* Add properties for the username, and profileImageURL(all string types) to your User class
* Parse the JSON file into tweets, make sure all properties on each tweet are being set. All parsing should be done in your TweetJSONParser class.
* Display those tweet objects in the table view, just the text for the tweet is fine today
* **Code Challenge:**
	* Write a function that reverses an array

###Reading Assignment:
* General Concepts:
  * MVC
* Apple Documentation:
  * NSJSONSerialization
  * NSBundle
  * UITableView

##Other Resources
* [Reading Assignments](../../Resources/ra-grading-standard/)
* [Reading Assignments](../../Resources/ra-grading-standard/)
* [Grading Rubrics](../../Resources/)
* [Lecture Resources](lecture/)
* [Lecture Slides](https://www.icloud.com/keynote/000JOeuDHWuUbUJrSdhFhQJcg#Week2_Day1)

XCODE & GIT!

Open standard format that uses human readable text to transmit tdata objects consisting of attribute - value pairs.

Used primarily for communication between the server and client in all stacks/programming languages.

Is a more popular alternative to XML
The official internet media type is json is application/JSON

Event triggers network request (the pull down requests data from twitter api)
the servier receives the request, process it and sends back the response--we are looking for code: 200
the client receives the response, checks for errores and then serializes JSON "data payload" into objects.
The client parases through the objects nad creates model objects.
The client displays modeul objects to the user.

NSJONSERIALIZATION class!  Converts raw JSON data (raw bytes) you get back from a network service native types and vice versa.
Data requests give binary data.  Use NSJSONSERIALIZATION to convert from binary to JSON data, and then the network creates the JSON objects.

do {
	let JSON = try NSJSONSerialization.JSONObjectWithdata(data, options:..)
}
catch {
	print(error)
}

catching errors?  NSData errors.

NSJSONReadingMutableContainers - specifies arrays and dictionaries are created as mutable objects
NSJSONReadingMUtableLeaves
NSJSONReadingAllowFragments

by default, a good API will provide data in a dictionary or array.

#BUNDLES!

Fundamental technoligy that are used to encapsulate code and resources here.

a bundle is a directory with a standard hierarchial structure that holds code and resource for code.

Bungles provide progrmaming interfaces for accessing the contents of bungles in your code.
There a number different types of bunles but the most important is applicationThe application bungle stores everything your app requires to run successfully.

Info.plist - a plist file that contains configuration information for your application.  The system relies on this to know what your app is.(users of non-phone devices like iPad or iPod will not be able to download)

Executable - All apps must have an executable file.  This file has apps main entry point and nay code that was staiticsally linked to your app's target.

Resource files Any data that lives outside oyur apps executable file.

NSBundle class represents a bundle in code.
NSBundle has a class method mainBundle(), which returns the bundle that contains the code and resources for runnign app
You can access other bundles with aren't the main bundle by using bundleWithPath() and passing in a path to another bundle (uncommon)
You can get the path for resource by using pathForResource(ofType:)

The app must be loaded into memory.
NSBundlemainbundle().pathForResource(tweet of type"JSON")

Tableviews & cells

Presents data in a scorlllable list of mutiple rows that may be divided into sections.

#INTERVIEW QUESTION:  waht is the difference between tableview and collections and when would you use which?
If we need to display data in a single column forever, tableview is a great way to do it.
Collection would have multiple columns/rows.

you can create a tableview out of a collectionview.
collectionviews are more involved, they're more generic and need more defined.

Tableview is one column only.

Tableview has 0 through n-1 sections, those ssections have 0 through n-1 rows.  A lot of the time you will just have 1 section and its corresponding row.
Sections are displayed with headers and footers and rows are displayed with TblaeView Cells both of which are subclass ofUIView.
table view is a subclass of UITableViewViews can take any shape and size, go anywhere on screen
Tableview doesn't have to be be full screen.
Tableviews rely on the concept of delegation to work.
Tableview has two delegate objects, One called delegate, the other alled data source.  Delegate is responsible for all user interactions wiht the table view, data source is responsible for supply the table view with data to show.

func tableView(.., numberOfRowsInSection:..) -> interactions{
	return 0
}
func tableView(.. cellForRowAtIndexPath indexPath:..) -> UITab`l`eViewCell
{
	let cell = ..,
	return cell
}

#WHY ARE TABLEVIEWS SO EFFICIENT?
A tableview will create


Tableviews reuse table view cells.  So you need to make sure you probably scrub old data before showing new data again.
This clean up can tak place in your cellForRowAtIndexPath method, most of the time you are already doing it by diving its labels and views new data that overwrite the old data.

create xcode project - single view application
save to desktop.
quit project.
termianl, cd into folder
git status
git init
nano .gitignore (git-ignore CTL O, CTL X)
git Add
git commit!

AppDelegate.swift = delete everything except the first one. (application)

Create New Group from Selection (App Global)(Controller)
put mainstoryboard, assets, launch in View.


info.plist inside app global.
appdelegate.swift in app Global

git Add
git status
git commit!

Select app global, add file, add tweet.json file
Tweet:  text id user
user:  name, profile, location

create new model classes.
tweet.swift
user.swift
make a model folder.
put them in model

in tweet.swift

class Tweet {
	let text: string
	let id: string
	let user: User?

	init?(json: [String:AnyObject])
	{
		if let name = json["name"] as? String, profileImageUrl = json["profile_image_url"] as? string, location = json["location"] as? string?
		{
			self.name = name
			self.profileImageUrl = profileImageUrl
			self.location = location

		} else
		{
		return nil
	}
}
}

in user.swift

class User{
	let name: string
	let profileImageUrl: string
	let location: string
	init? (json: [String: AnyObject]) //common practice reference any object
		{
			if let text = json["text"] as? String, id = ["id_str"] as? String, user = json["user"] as? [String: AnyObject]  //common practice when referencing any object
			{
				self.text = text
				self.id = id
				self.user = User(json: user)
			} else {
			return nil
				}
			}
}

termianl, git add
git commit
#consider this before working with tweet.swift or user.swift
create new file source swift JSONParser.swift inside Utility folder

type alias = JSONParserCompletion = (success: Bool, tweets; [Tweet]? -> ())

class JSONParser
{
	class func tweetJSONFrom(data: NSData, completion: JSONParserCompletion)
	{
		do {
			if let rootObject = try NSJSONSerialization(self.JSONData()//(this was changed to data), options: .MutableContainers) as? [[String:AnyObject]]
			var tewets = [Tweet]()
			fofr tweetJSON in rootObject {
				if let tewet = Tewet(json: tewetJSON)
				{
					tewets.append(tweet)
				}
			}
			//completion on success
			completion(success: true, tewets: tewets)
				}
	}
catch {
	print("Error!  Serializing failed")
	completion(success: false, tewets: nil)
}
}

	//this following func is only for today with loca ldata
	class func JSONData() -> NSData
	{
		guard let tweetJSONPath = NSBundle.mainBundle().URLForResource("tweet", withExtension: "json") else {
			fatalError("tweet.json does not exist")
		}
		guard let tweetJSONData = NSData(contentsOfUrl: tweetJSONPath) else {fatalError("Failed to convert JSON to data")}
		return tweetJSONData
	}
}

######:
go to viewController

class ViewController: UIViewController
override func viewDidLoad()
{
	super.viewDidLoad()
	JSONParser.tweetJSONFrom(JSONParser.JSONData()) {
		(success, tewets) in if success {
			for tewet in tewets! {
				print(tewet.text)
			}
		}
	}
}

git status
git add
git commit

go to main storyboard
opeun utilities, query in "filter" -> "table view"

auto layout - Add New Constraints (uncheck Constrain to margins), select the lines to make them red, "Add 4 Constraints"

Drag the cell onto the prototype.

Make sure Table View Cell is selected.
From belt buckele, select Style: BAsic
add identifier, "tweetCell"

Control drag from tableview to viewcontroller yellow circle
(SPECIFY datasource)

go to ViewController.swift

inside classViewController: UIViewController
add global var:
@IBOutlet weak var tableView: UITableView!
var datasource = [Tweet]() {
	didSet {
		self.tableView.reloadData()
	}
}

extension ViewController: UITableViewDataSource
{
	tbaleView(tableView: UITableView, numberOfRowsInsection section: Int) -> int
	{
		return self.datasource.count
	}
	tableview(tableview; UITableview, cellForRowAtIndexPath indexPath: NSIndexPath) - UITableViewCell
	{
		let cell = tableView.dewueueResueableCellWithidentifier("tewetCell", forIndexPath: indexPath)
		let tewet = self.datasource[indexPath.row]
		cell.textLabel?.text = tewet.text
		return cell
	}
}

CREATING A CONNECTION FROM TABLEVIEW TO CODE.  IN UTILITIES, TWO CIRCLES INTERSECTING WILL BRING UP ASSISTANT EDITOR, CLICK ViewController (YELLOW CIRCLE WHITE CENTER)

control drag from table view to code directly, popup occurs: name: tableView

(@IBOutlet weak var tableView: UITableView!)

override func viewWillAppear(animated: Bool)
{
	super.viewWillAppear(animated)
	bring in the JSONparser.tweetJSONFrom() blah blah info and inside:

	 blah blah in
	if success {
		if let tewets = tewwets {
			self.datasource = tewets
		}
	}
}

terminal git status
git add
git commit

done.....?

----

arrays are contiugous blocks of data stored in memory.
a block of memory will be created for bytes * the array.
n * sizeof(object of array)
each object inside the array is right next to each other, it's a single chunk and it's an ordered chunk.
