//
//  ChatViewController.swift
//  ChatClient
//
//  Created by Saurabh Shah on 9/24/15.
//  Copyright © 2015 Saurabh Shah. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageText: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    var messages: [PFObject]?
    
    @IBAction func onClickSendButton(sender: AnyObject) {
        var message = PFObject(className:"Message")
        message["text"] = messageText.text
        message["user"] = PFUser.currentUser()
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("Message Sent")
                // The object has been saved.
            } else {
                print("Message Sent Error")
                // There was a problem, check error.description
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if messages != nil{
            return messages!.count
        }else{
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let messageCell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath) as! MessageCell
        if self.messages != nil{
            messageCell.messageLabel.text = messages![indexPath.row]["text"] as! String
            if messages![indexPath.row]["user"] != nil{
                messageCell.userLabel.text = messages![indexPath.row]["user"].username
            }
            
        }
        
        return messageCell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMessages()
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "fetchMessages", userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
    func fetchMessages(){
        print("Refresh called.")
        let query = PFQuery(className:"Message").includeKey("user").orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (messages:[PFObject]?, error:NSError?) -> Void in
            self.messages = messages
            self.tableView.reloadData()
        }
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
