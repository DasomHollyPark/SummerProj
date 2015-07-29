//
//  signUpViewController.swift
//  noName
//
//  Created by DasomPark on 7/24/15.
//  Copyright (c) 2015 Dasom. All rights reserved.
//

import UIKit
import Parse

class signUpViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var actInd : UIActivityIndicatorView = UIActivityIndicatorView(frame:CGRectMake (0,0,150,150)) as UIActivityIndicatorView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.actInd)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpAction(sender: AnyObject) {
    
    
    
    
        var username = self.usernameField.text
        var password = self.passwordField.text
        
        if(count(username.utf16)   < 1 || count(password.utf16) < 1){
            var alert = UIAlertView(title: "Invalid", message: "Username and password must be greater than 1 letter", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }else{
            
            self.actInd.startAnimating()
            var newUser = PFUser()
            
            newUser.username = username
            newUser.password = password
            
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                self.actInd.stopAnimating()
                if(error != nil){
                    var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }else{
                    var alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    self.performSegueWithIdentifier("signUpSuccess", sender: self)
                }
            })
            
        }
    
    
    
    
    
    
    
    
    }
    
    

    
    @IBAction func hideKeyboard(sender: AnyObject) {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    
    @IBAction func backAction(sender: AnyObject) {
        self.performSegueWithIdentifier("back", sender: self)
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
