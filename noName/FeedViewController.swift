//
//  FeedViewController.swift
//  noName
//
//  Created by DasomPark on 7/29/15.
//  Copyright (c) 2015 Dasom. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var postsArray:[String] = [String]()
    
    @IBOutlet weak var postTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postTableView.delegate = self
        self.postTableView.dataSource = self
        
        // Do any additional setup after loading the view.
        
        //Add some sample data so that we can see something
        self.postsArray.append("TEST 1")
        self.postsArray.append("TEST 2")
        self.postsArray.append("TEST 3")
        self.postsArray.append("MEOW")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //create a table cell
        let cell = self.postTableView.dequeueReusableCellWithIdentifier("postCell") as! UITableViewCell
        //customize the cell
        cell.textLabel?.text = self.postsArray[indexPath.row]
        //return the cell
        return cell
        
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
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
