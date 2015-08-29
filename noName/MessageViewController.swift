//
//  FeedViewController.swift
//  noName
//
//  Created by DasomPark on 7/29/15.
//  Copyright (c) 2015 Dasom. All rights reserved.
//

import UIKit
import Parse

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    var postsArray:[String] = [String]()
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var dockViewHeight: NSLayoutConstraint!
    @IBOutlet weak var dockViewHeightCons: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postTableView.delegate = self
        self.postTableView.dataSource = self
        self.messageTextField.delegate = self
        
        
        //Add a tap gesture recognizer to the viewTable
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "postViewTapped")
        self.postTableView.addGestureRecognizer(tapGesture)
        
        //TEST
        self.retrieveHashtagChats()
        
        //Retrieve Message from Parse
        self.retrieveMessages()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.retrieveMessages()
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
        
        //cell.textLabel?.textColor = UIColor.blueColor()
        
        //return the cell
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    @IBAction func sendButtonTapped(sender: AnyObject) {
        //Call the endEditiing for the textField
        
        
        self.messageTextField.endEditing(true)
        
        //Disable textField and button
        //  self.messageTextField.enabled = false
        // self.sendButton.enabled = false
        
        //Create a PFObject
        var newMessageObject: PFObject = PFObject(className: "Message")
        //Text key = messageTextField
        newMessageObject["Text"] = self.messageTextField.text
        newMessageObject["user"] = PFUser.currentUser()
        newMessageObject["hashtag"] = currentHashtagObject
        
        
        
        newMessageObject.saveInBackgroundWithBlock { (success:Bool, NSError) -> Void in
            if(success){
                
                println("Message has been saved")
                self.retrieveMessages()
            }
            else{
                println("FAILED =( ")
            }
            
            dispatch_async(dispatch_get_main_queue()){
                self.messageTextField.text = ""
            }
            
            //   self.messageTextField.enabled = true
            //     self.sendButton.enabled = true
        }
        
        
    }
    
    //MARK: TextFieldDelegate Method
    func textFieldDidBeginEditing(textField: UITextField) {
        //an animation to grow the dockview
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.5, animations: {
            
            
            self.dockViewHeightCons.constant = 300
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        //an animation to grow the dockview
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.5, animations: {
            
            
            self.dockViewHeightCons.constant = 60
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        
    }
    
    func postViewTapped() {
        //Force the text Field
        self.messageTextField.endEditing(true)
    }
    
    func retrieveMessages(){
        //Create a new PFObject
        var query:PFQuery = PFQuery(className: "Message")
        query.whereKey("hashtag", equalTo: currentHashtagObject)
        println("AM I BEING CALLED???")
        query.orderByAscending("createdAt")
        //Call find objects in background with block
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            //Clear the postsArray
            self.postsArray = [String]()
            
            
            //Loop through the objects array
            for messageObject in objects! {
                
                //Retrieve the text colume value of each PFObject
                let messageText :String? = ((messageObject as! PFObject)["Text"] as! String?)!
                
                
                //Assign it into postsArray
                if self.messageTextField != nil{
                    
                    
                    var query = PFQuery(className: "_User")
                    let finduser :PFObject = query.getObjectWithId(((messageObject as! PFObject)["user"]!.objectId as String?)!)!
                    
                    let username :String = (finduser["username"] as! String?)!
                    var messageTextContent :String = username
                    
                    messageTextContent += " : "
                    messageTextContent += messageText!
                    self.postsArray.append(messageTextContent)
                    
                    
                    
                }
            }
            
            dispatch_async(dispatch_get_main_queue()){
                
                //Reload the table view
                self.postTableView.reloadData()
                self.tableViewScrollToBottom(true)
            }
        }
        
    }
    
    
    
    func retrieveHashtagChats(){
        
        var query: PFQuery = PFQuery(className: "Message")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.findObjectsInBackgroundWithBlock{ (objects: [AnyObject]?, error: NSError? ) -> Void in
            
            if(error == nil){
                
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println(object.valueForKey("Text"))
                        
                        var query2 = PFQuery(className: "Hashtag")
                        query2.whereKey("objectId", equalTo: (object.valueForKey("hashtag")?.objectId)!)
                        query2.findObjectsInBackgroundWithBlock{(objects2: [AnyObject]?, error: NSError?) -> Void in
                            
                            if(error == nil){
                                if let objects2 = objects2 as? [PFObject] {
                                    for object2 in objects2{
                                        println(object2["hashtagName"])
                                    }
                                }
                            }
                            
                            
                        }
                        
                    }
                }
            }else{
                println("failed to retreieve hashtagChats!")
                println(error)
                
            }
            
            
        }
    }
    
    func tableViewScrollToBottom(animated: Bool) {
        
        let delay = 0.1 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            
            let numberOfSections = self.postTableView.numberOfSections()
            let numberOfRows = self.postTableView.numberOfRowsInSection(numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
                self.postTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: animated)
            }
            
        })
    }
    
    
    
}
