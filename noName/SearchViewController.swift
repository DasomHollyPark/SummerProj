//
//  SearchViewController.swift
//  noName
//
//  Created by DasomPark on 8/6/15.
//  Copyright (c) 2015 Dasom. All rights reserved.
//

import UIKit
import Parse


class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var userLists: UITableView!
    
    var searchResults = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let myCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as! UITableViewCell
        myCell.textLabel?.text = searchResults[indexPath.row]
        
        
        return myCell
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        //KEyboard disappear
        searchBar.resignFirstResponder()
        
        var usernameQuery = PFQuery(className: "_User")
        usernameQuery.whereKey("username", equalTo: searchBar.text)
        
        usernameQuery.findObjectsInBackgroundWithBlock{
            (results: [AnyObject]?, error: NSError?) -> Void in
            
            if error != nil{
                
            }
            if let objects = results as? [PFObject] {
                self.searchResults.removeAll(keepCapacity: false)
                
                for object in objects{
                    let username = object.objectForKey("username") as! String!
                    
                    self.searchResults.append(username)
                    
                    
                }
                dispatch_async(dispatch_get_main_queue()){
                    self.userLists.reloadData()
                    self.searchBar.resignFirstResponder()
                }
            }
        }
        
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar){
        
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
    
    @IBAction func addFriendToNewChat(sender: AnyObject) {
        var query: PFQuery = PFQuery(className: "_User")
        query.whereKey("username", equalTo: searchResults[0])
        query.findObjectsInBackgroundWithBlock{(objects: [AnyObject]?, error: NSError?) -> Void in
            if(error == nil){
                //Username Found
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        var newMessageObject: PFObject = PFObject(className: "Message")
                        //Text key = messageTextField
                        var inviteMsg: String = PFUser.currentUser()!.username!

                        inviteMsg += " invited "
                        inviteMsg += self.searchResults[0]
                        newMessageObject["Text"] = inviteMsg
                        newMessageObject["user"] = object
                        newMessageObject["hashtag"] = currentHashtagObject
                        newMessageObject.saveInBackgroundWithBlock{(success: Bool, NSError) -> Void in
                            if(success){
                                
                            }else{
                                
                            }
                        }
                        
                    }}
                
            }else{
                
            }
            
        }
    }
    @IBAction func refreshButton(sender: AnyObject) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searchResults.removeAll(keepCapacity: false)
        userLists.reloadData()
        
        
    }
}
