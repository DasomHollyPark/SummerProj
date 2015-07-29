//
//  AuthViewController.swift
//  noName
//
//  Created by DasomPark on 7/24/15.
//  Copyright (c) 2015 Dasom. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class AuthViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate{

    
    var logInViewController: PFLogInViewController = PFLogInViewController()
    var signUpViewController: PFSignUpViewController = PFSignUpViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        //the user is not signed up yet
        if(PFUser.currentUser() == nil){
            //show the login & signup View controller
            self.logInViewController.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.LogInButton | PFLogInFields.SignUpButton | PFLogInFields.PasswordForgotten | PFLogInFields.PasswordForgotten
            
            var logInLogoTitle = UILabel()
            logInLogoTitle.text = "noNameYet"
            self.logInViewController.logInView!.logo = logInLogoTitle
            
            self.logInViewController.delegate = self
            
            var signUpLogoTitle = UILabel()
            signUpLogoTitle.text = "noNameYet"
            
            self.signUpViewController.signUpView!.logo = signUpLogoTitle
            self.signUpViewController.delegate = self
            
            self.logInViewController.signUpController = self.signUpViewController
            
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: PARSE Log In
    
    //Check if the username and password is empty
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        if(!username.isEmpty || !password.isEmpty){ //if they are both filled
            return true
        }else{
            return false
        }
    }
    
    
    //Did log in user
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        println("failed to log in")
    }
    
    
    //MARK: Parse Sign Up
    

    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        println("User canceled to sign up")
    }
    
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        println("failed to sign up with error")
    }
    
    //MARK: Actions
    //BUTTON =)
    @IBAction func simpleAction(sender: AnyObject){
        
        self.presentViewController(self.logInViewController, animated: true, completion: nil)
    }
    
    @IBAction func customAction(sender: AnyObject) {
        self.performSegueWithIdentifier("custom", sender: self)
    }
    
    @IBAction func logOutAction(sender: AnyObject) {
        PFUser.logOut()
    }
    
    
    
}
