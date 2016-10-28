//
//  DownloadsViewController.swift
//  ITP344Homework
//
//  Created by Dylan Kyle Davis on 2/9/16.
//  Copyright © 2016 Dylan Davis. All rights reserved.
//

import UIKit

class DownloadsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var downloadsTableView: UITableView!
    
    let links:NSArray = ["https://upload.wikimedia.org/wikipedia/commons/d/d8/NASA_Mars_Rover.jpg",
    
    "http://www.wired.com/wp-content/uploads/images_blogs/wiredscience/2012/08/Mars-in-95-Rover1.jpg",
    
    "http://news.brown.edu/files/article_images/MarsRover1.jpg",
    
    "http://www.nasa.gov/images/content/482643main_msl20100916-full.jpg",
    
    "https://upload.wikimedia.org/wikipedia/commons/f/fa/Martian_rover_Curiosity_using_ChemCam_Msl20111115_PIA14760_MSL_PIcture-3-br2.jpg",
    
    "http://mars.nasa.gov/msl/images/msl20110602_PIA14175.jpg",
    
    "http://i.kinja-img.com/gawker-media/image/upload/iftylroaoeej16deefkn.jpg",
    
    "http://www.nasa.gov/sites/default/files/thumbnails/image/journey_to_mars.jpeg",
    
    "http://i.space.com/images/i/000/021/072/original/mars-one-colony-2025.jpg?1375634917",
    
    "http://cdn.phys.org/newman/gfx/news/hires/2015/earthandmars.png"]
    
    var downloads:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.downloadsTableView.delegate=self
        self.downloadsTableView.dataSource=self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func downloadsButtonPressed(sender: AnyObject) {
        
       
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
            
            var bTask:UIBackgroundTaskIdentifier = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({
                
                print("Not enough time to complete")
                
            })
            
            for i in 0..<self.links.count {
                
                if(UIApplication.sharedApplication().backgroundTimeRemaining > 170) {
                    let URL:NSURL = NSURL(string: self.links[i] as! String)!
                    let data:NSData = NSData(contentsOfURL: URL)!
                
                    print("Beginning download")
                    let image:UIImage = UIImage(data: data)!
                    NSThread.sleepForTimeInterval(3)
                    print("Finished download")
                
                    print("Time remaining: ", UIApplication.sharedApplication().backgroundTimeRemaining)
                
                    self.downloads.append(image)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                        let indexPath:NSIndexPath = NSIndexPath(forItem: (self.downloads.count-1), inSection: 0)
                        self.downloadsTableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                    
                    })
                }
                else {
                    
                    print("Not enough time to download");
                }
            }
            UIApplication.sharedApplication().endBackgroundTask(bTask)
            bTask = UIBackgroundTaskInvalid
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.downloads.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("link", forIndexPath: indexPath)
        
        cell.imageView?.image = self.downloads[indexPath.row]
        cell.textLabel?.text = self.links[indexPath.row] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
