//
//  UserTimeLineViewController.swift
//  derekg.week2
//
//  Created by Derek Graham on 6/16/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

import UIKit

class UserTimeLineViewController: UIViewController, UITableViewDelegate, Identity {
    
    @IBOutlet var tableView: UITableView!
    var tweet: Tweet?
    var tweets = [Tweet](){
        didSet{
            self.tableView.reloadData()
    
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
