//
//  chatListViewController.swift
//  noName
//
//  Created by DasomPark on 8/21/15.
//  Copyright (c) 2015 Dasom. All rights reserved.
//

import UIKit
import Parse

class chatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chatTableView: UITableView!
    var chatListArray:[String] = [String]()
    var hashtagText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chatTableView.delegate = self
        self.chatTableView.dataSource = self
        
        self.retrieveChatLists()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.hashtagText = chatListArray[indexPath.row]
        self.findHashtag()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Create the cell
        let cell = self.chatTableView.dequeueReusableCellWithIdentifier("chatCell") as! UITableViewCell
        
        //Customize the cell
        cell.textLabel?.text = self.chatListArray[indexPath.row]
        //Return the cell
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatListArray.count
    }
    
    
    func retrieveChatLists(){
        
        //qeury : retrieve all messages created by curent user
        var query: PFQuery = PFQuery(className: "Message")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.findObjectsInBackgroundWithBlock{ (objects: [AnyObject]?, error: NSError? ) -> Void in
            
            if(error == nil){
                
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println(object.valueForKey("Text"))
                        
                        //query2 : find a hashtag object that the message has relation with
                        var query2 = PFQuery(className: "Hashtag")
                        query2.whereKey("objectId", equalTo: (object.valueForKey("hashtag")?.objectId)!)
                        query2.findObjectsInBackgroundWithBlock{(objects2: [AnyObject]?, error: NSError?) -> Void in
                            
                            if(error == nil){
                                if let objects2 = objects2 as? [PFObject] {
                                    for object2 in objects2{
                                        
                                        //name : hashtagName (of the Message)
                                        var name: String = "#"
                                        name += object2["hashtagName"] as! String
                                        //If the chatListArray is empty, then append name to the array
                                        if(self.chatListArray.count == 0){
                                            self.chatListArray.append(name)
                                            //If the chatListArray is NOT empty, then
                                        }else{
                                            //Suppose chat does not exist
                                            var chatExists = false
                                            for chat in self.chatListArray{
                                                //If you found a same element in the array, then chatExists == true
                                                if(chat == name){
                                                    chatExists = true
                                                }
                                            }
                                            
                                            //after all. If chat did not exist, then append name to the array
                                            if(chatExists == false){
                                               
                                                self.chatListArray.append(name)
                                            }
                                            
                                            self.chatTableView.reloadData()
                                        }
                                    }
                                }
                            }
                            
                        }
                        
                        
                    }
                }
                self.chatTableView.reloadData()
            }else{
                println("failed to retreieve hashtagChats!")
                println(error)
                
            }
            
            
        }
        
    }
    
    @IBAction func findHashtag() {
        hashtagNameText = hashtagText
        
        let query = PFQuery(className: "Hashtag")
        query.whereKey("hashtagName", equalTo: hashtagNameText)
        query.getFirstObjectInBackgroundWithBlock{
            (object :PFObject?, error: NSError?) -> Void in
            
            if object == nil{
                println("ERROR")
            }else{
                println("HELLEOW")
                currentHashtagObject = object!
                println(object)
                
            }
        }
        
    }
    
    
    
}
