#Week 2 - Class 3
##Homework
* Setup your cells with auto layout so you can see the entire tweets text. If you get any .... at the end that is probably twitters API being stupid
* Create a 2nd view controller that shows an individual tweet in detail
* Upon clicking a tweet, your interface should push (which means you need a navigation controller) to the 2nd view controller and display the tweet selected, but with a few caveats:
* If the tweet that was selected is a retweet, show the original tweet and the original user
* All of this information is available in the original JSON, you just have to go digging for it, and then add properties to your Tweet class accordingly.
* Create a ProfileViewController that when presented, shows the logged in user's profile information. Utilize the NavigationBar to add a button to present this new viewController.

###Reading Assignment:
* Apple Documentation:
  * [Auto Layout](https://developer.apple.com/library/watchos/documentation/UserExperience/Conceptual/AutolayoutPG/Introduction/Introduction.html)
  * [UIActivityIndicator](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIActivityIndicatorView_Class/index.html)
  * [UINavigationController](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UINavigationController_Class/index.html)
  * [UIStoryboardSegue](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIStoryboardSegue_Class/)
  * [NSLayoutConstraint](https://developer.apple.com/library/mac/documentation/AppKit/Reference/NSLayoutConstraint_Class/index.html)

##Other Resources
* [Reading Assignments](../../Resources/ra-grading-standard/)
* [Grading Rubrics](../../Resources/)
* [Lecture Resources](lecture/)
* [Lecture Slides](https://www.icloud.com/keynote/000clqbz13p8N-0ljiqMLD-0w#Week2_Day3)

#LINKED LISTS AND
#THIS WEEKS APP!  What is the flow of the app, what is the model, how does it work?

Autolayout is a constraint-based layout system.
Flexible and feature reich.
Constraints are fundamental building block of auto loayout.
Constraints express rules for the layout of elements in your interfaceThere should only be ONE POSSIBLE LAYOUT.  
For example, a view width + leading and trailing constraint would cause auto layout to complain.

Constraints are always attached to attributes.
An attribute is one of left, right, top, bottom, leading, trailing, width, height, centerX, centerY, baseline.

Every view has each one of these attributes.

Constraints take the fofrm of the equaltion y = mx + b.  This translates to firstItem.attribute = secondItem.attribute * multipler + constantly
Constant = physical size or offset, in points, of the Constraint
Multipler = useful for creating ratios
Most constraints have both a firstItem and secondItem in their equation but width and height constraints often only have firstItem.

Constraints are objects.  The class is called NSLayoutConstraint
Every UIView has a method called constraints() that returns an array of all constraints held by that view.
Constraints can be created in code like any object.
You can create outlets to constainrs from the storyboard.

Every view that has an intrinisic content size has attributes which define how constraints are built to show that size.
The fifrst one is CONTENT HUGGING PRIORITY which dictates how much view resists growing due to constraints.

The second is COMPReSSION RESISTANCE, which dictates how much the view resists shrinking due to constraints..Both of these categories have 2 values, one for horizontal and one for vertical.
XCode will tell you if you need to adjust.

AUTOMATIC ROW heightA way to dynamically resize cells based on teh content.

WORKFLOW.
Ensure propert auto layout SetupEnsure the elements tht are going to be dynamic and dictating the height don't have fixed height constraints.
#Modify the settings of the elements(LABEL SET LINES TO 0 FOR TEXT VIEW DISABLE SCROLLING)
Give your table view an estimatedRowHeight and then set its rowHeight to UITAbleviewAutomaticdimensions

self.estimatedRowHeight = UITAbleviewAutomaticdimensions in the viewDidLoad

Activity Indicator!

Show an activity indicator to show that a task is in progress.

Spins while a task is progressing and disappears when task is complete.
Doesn't allow user interaction.
Actiity indicator assures the user their task or process hasn't stalled.

Drag it out from the storyboard, place it at the bottom of the view hierarchy
Give it constraints just like any other view.
Create an outlet for it.
Call startAnimated when you want to start showing progress to a user, and stopanimated when the task is complete.
It is your responsibility to hide/remove the indicator (most be stopped and hidden)


#NAVIGATION CONTROLLER!
content view controllers - present apps content.  used to populate views from data from the model and respond to user actions.

Container view controllers - used to manage content view controllers

Container view contorllers are the parent, and content view controllers are the children.

Contant View Controllers manage content, Container View Controllers manage Content View Controllers.

Navigation controller keeps strong leashes on all view controllers its managing.
When a view controller is dismissed (AKA POPPED!) it will be destroyed because nothing else has a strong leash on it.
Every view controller has a property called navigationController

ARC!

UINAVIGATION item!
Provides the content that the navigation bar displays.  It is a wrapper object that manages the buttons and views to display in a navigation bar and each view controller has its own.

The managing navigation controler uses the navigation items of the topmost two view controllers to populate the navigating bar with content.

The navigation bar keeps a stack of all the items, in the exact same order as the navigation controller keeps track of its child content view controllers.

Each view controller has a property that points to its corresponding navigation item.

The navigation bar has 3 positions for an item to fill: left, center, right.

USEFUL PROPERTIES!

hideBarsOnTap
hideBarsOnSwipe
hidesBarsWhenVerticallyCompact
hidesBarsWhenKeyboardAppears
barHideOntapGestureRecognizer
barHideOnSwipeGestureRecognizer

Activity indicator - shows that a task is in progress

interface objects must have its font set to a "text Style" - UIFontTextStyleHeadline, UIFontTextSTyleBody... etc

Whenever the user dras that slider to change the size of the next, we need to listen for a change notification UIContentSizeCategoryDidChangeNotification

Whenever the notification is sent, we need to respond by updating the UI.

func update()
{
  label.font = UIFont.preferredFontForTextStyle(.Headline)
}

-----
view
table viewtweetCell
Content view
Title
....

select "Title", attributes inspector(third from the right, downward pointing arrow), update lines from 1 to 0.

go to viewController

between override func viewWillApepar and func update(or didReceiveMemoryWarning)

func setUpTableView()
{
  self.tableView.estimatedRowHeight = 100
  self.tableView.rowHeight = UITableViewAutomaticDimension
}


CREATE NEW VIEWCONTROLLER!
Select iOS Source Cocoa Touch Class (not swift!)
make sure subclass of: UIViewController
Name: DetailViewCOntroller
(make sure also create XIB file unchecked, and language = swift)

Go to main storyboard.
Grab a View COntroller, drag and drop nxt to existing View controller so there are two view controllers on the storyboard.

go to Identifier (third from the left) square.  Select yellow circle and chang ethe Class to be DetailViewController (and Storyboard ID)

select the MAIN viewcontroller yellow cicle, click Editor (top of screen)-> Embed In -> Navigation Ctonroller

go to star wars and make sure tableview is still at 0.

select prototype cell, control drag to DetailViewController SELECT show

go to override func viewDidLoad() on ViewCOntroller.swift inside...

super.viewDidLoad()
self.****WHAT***
self.navigationItem.title = "TWTR"

Go to main story board, go to object library.  Select label and drag it to the Detail View Controller.  Resize the label to go against the right and left margins.
Go to attributes inspector (downward pointing pencil) and make sure Alignment: centered
Lines: 0


(left and right terminology in the storyboard are leading and trailing)
(don't really have to deal with vertical because the labels know how tall it should be)

set leading and trailing constraints (20 points)
Centered veritcal container

Control drag from tweet label to DetailViewCOntroller call it "tweetLabel"

inside viewdidLoad, add self.tweetLabel.text = "derpderpderpderp"

Create a new label under tweet called username
select username, control drag to tweet label and select Vertical Spacing

Control drag from username to tweet again, Center Horizontally

SELECT SEGUE BETWEEN view Controller and DetailViewCOntrollerselect attributes inspector (down pencil)
Identifier: DetailViewCOntroller


CREATE NEW APP GLOBAL Identity.swift
protocol Identity {
  static func id() -> String
}

extension Identity {
  static func id() -> String{
    return String(self)
  }
}


go to DetailViewCOntroller
add inside class:

class DetailViewController: UIViewController, Identity
{
  var tweet: Tweet?
  override func viewDidLoad()
  {
    super.viewDidLoad()
      if let tweet = self.tweet {
        self.tweetLabel.text = tweet.text
        self.userLabel.text = tweet.user?.name
      }
  }
}

go to viewController
below didReceiveMemory, create:
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
{
  if segue.identifier == DetailViewController.id()
  {
    guard let DetailViewController = segue.destinationViewController as? DetailViewController else { return }
    let indexPath = self.tableView.indexPathForSelectedRow else { return }
    detailViewController.tweet = self.database[indexPath.row]
  }
}

IF TWEET WAS RETWEET, you must show the original tweeter.
Review tweet.swift add under the constants....
var retweet: Tweet?

inside init?

if let retweetJSON = json["retweeted_status"] as? [String : AnyObject] {
  if let retweet = Tweet(json: retweetJSON)
  if self.retweet = retweet
}


insidie DetailViewController
inside
if let tweet = self.tweet {

if let retweet = tweet.retweet {
  self.tweetLabel.text = retweet.text
  self.userLabel.text = retweet.user?.name
} else {
  .....tweet stuff that should be there.
}
}


------
