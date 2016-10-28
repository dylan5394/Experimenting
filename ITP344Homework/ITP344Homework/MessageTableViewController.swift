//
//  MessageTableViewController.swift
//  ITP344Homework
//
//  Created by Dylan Kyle Davis on 1/28/16.
//  Copyright © 2016 Dylan Davis. All rights reserved.
//

import UIKit

class MessageTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private var posts : Array<Post>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadTableData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadTableData() {
        
        PostsManager.readPostsWithHandler{
            (posts : Array<Post>?, error: AnyObject?) in
            
            self.posts = posts
            
            dispatch_async(dispatch_get_main_queue(), {
                () -> Void in
                
                self.tableView.reloadData()
                
            })
            
        }
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let posts = posts {
            return posts.count
            
        }
        return 0
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "message"
        
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        let post : Post = self.posts[indexPath.row]
        
        cell.textLabel?.text = post.cName
        cell.detailTextLabel?.text = post.cMessage

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        if editingStyle == .Delete {
            
            if let messageID = posts[indexPath.row].cID as? NSNumber {
                
                    let request = NSMutableURLRequest(URL: NSURL(string: "\("https://freezing-cloud-6077.herokuapp.com/messages")/\(messageID)")!)
            
                    request.HTTPMethod = "DELETE"
                
                    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
                    let session = NSURLSession(configuration: config)
                    let task = session.dataTaskWithRequest(request){
                        (data, response, error) -> Void in
                        if error != nil {
                            print("Error calling delete")
                        } else {
                            //post was deleted
                        }
                }
                task.resume()
                
            }

            posts.removeAtIndex(indexPath.row)
                        
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
