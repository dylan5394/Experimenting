//
//  FacebookLoginViewController.swift
//  ITP344Homework
//
//  Created by Dylan Kyle Davis on 2/23/16.
//  Copyright © 2016 Dylan Davis. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit
import UIKit

class FacebookLoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    var friends:[String] = []
    var photos = [String:String]()
    var id = [String:String]()
    var viewFriendsButton:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let loginButton:FBSDKLoginButton = FBSDKLoginButton()
        loginButton.center = self.view.center;
        loginButton.delegate = self
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        self.view.addSubview(loginButton)
        
        self.viewFriendsButton = UIButton()
        viewFriendsButton!.setTitle("View Friends", forState: .Normal)
        viewFriendsButton!.setTitleColor(UIColor.blueColor(), forState: .Normal)
        viewFriendsButton!.frame = CGRectMake(100, 400, 150, 50)
        viewFriendsButton!.addTarget(self, action: #selector(FacebookLoginViewController.friendsButtonTouched(_:)), forControlEvents: .TouchUpInside)
        viewFriendsButton!.enabled = false
        
        self.view.addSubview(viewFriendsButton!)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if((FBSDKAccessToken.currentAccessToken()) != nil && (FBSDKAccessToken.currentAccessToken()).hasGranted("user_friends") ) {
            
            self.loadFriends()
        }
    }
    
    func friendsButtonTouched(sender: UIButton!) {
    
        let dest:TaggableFriendsTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TaggableFriends") as! TaggableFriendsTableViewController
        dest.friends = self.friends
        dest.friendsPictures = self.photos
        self.navigationController?.pushViewController(dest, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if((FBSDKAccessToken.currentAccessToken()) != nil && (FBSDKAccessToken.currentAccessToken()).hasGranted("user_friends")) {
         
            self.loadFriends()
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
        self.viewFriendsButton?.enabled = false;
    }
    
    func loadFriends() {
        
        let params = ["fields": "name, picture"]
        let gRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/taggable_friends?limit=1000000", parameters: params)
        
        gRequest.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
            
            if error == nil {
            
                let friendObjects = result["data"] as! [NSDictionary]
                for friendObject in friendObjects {
                    self.friends.append(friendObject["name"] as! String)
                    self.photos[friendObject["name"] as! String] = (friendObject["picture"]!["data"]!!["url"] as! String)
                }
                self.friends = self.friends.sort()
                self.viewFriendsButton?.enabled = true
            
            } else {
            
            print("Error Getting Friends \(error)")
            
            }
        }
    }

    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.destinationViewController.isMemberOfClass(TaggableFriendsTableViewController)) {
         
            let dest:TaggableFriendsTableViewController = segue.destinationViewController as! TaggableFriendsTableViewController
            dest.friends = self.friends
        }
    }
  */

}
