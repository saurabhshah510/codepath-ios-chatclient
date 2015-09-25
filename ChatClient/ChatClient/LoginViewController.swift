//
//  LoginViewController.swift
//  ChatClient
//
//  Created by Saurabh Shah on 9/24/15.
//  Copyright © 2015 Saurabh Shah. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBAction func onSignUp(sender: AnyObject) {
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(userNameTextField.text!, password:passwordTextField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("Login Successful")
                self.performSegueWithIdentifier("ChatSegue", sender: self)
                // Do stuff after successful login.
            } else {
                print("Login Failed")
                // The login failed. Check error to see why.
            }
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
