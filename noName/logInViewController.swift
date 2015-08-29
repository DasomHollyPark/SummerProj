//
//  logInViewController.swift
//  noName
//
//  Created by DasomPark on 7/24/15.
//  Copyright (c) 2015 Dasom. All rights reserved.
//

import UIKit
import Parse
class logInViewController: UIViewController {

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
    
    //MARK: Log In Action
    @IBAction func logInAction(sender: AnyObject) {
        
        var username = self.usernameField.text
        var password = self.passwordField.text
        
        self.actInd.startAnimating()
        PFUser.logInWithUsernameInBackground(username, password: password) { (user, error) -> Void in
            self.actInd.stopAnimating()
            if((user) != nil){
            
                
                self.performSegueWithIdentifier("logInSuccess", sender: self)
                
            }else{
                var alert = UIAlertView(title: "Fail", message: "Failed to Log In", delegate: self, cancelButtonTitle: "Ok")
                alert.show()
            }
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
