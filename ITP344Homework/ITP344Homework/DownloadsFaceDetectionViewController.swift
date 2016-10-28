//
//  DownloadsFaceDetectionViewController.swift
//  ITP344Homework
//
//  Created by Dylan Kyle Davis on 2/16/16.
//  Copyright © 2016 Dylan Davis. All rights reserved.
//

import UIKit

class DownloadsFaceDetectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var downloadsTableView: UITableView!
    
    let links:NSArray = ["https://upload.wikimedia.org/wikipedia/commons/d/d8/NASA_Mars_Rover.jpg",
    "http://img2.tvtome.com/i/u/28c79aac89f44f2dcf865ab8c03a4201.png",
    "http://news.brown.edu/files/article_images/MarsRover1.jpg",
    "https://loveoffriends.files.wordpress.com/2012/02/love-of-friends-117.jpg",
    "http://www.nasa.gov/images/content/482643main_msl20100916-full.jpg",
    "http://www.facultyfocus.com/wp-content/uploads/images/iStock_000012443270Large150921.jpg",
    "http://mars.nasa.gov/msl/images/msl20110602_PIA14175.jpg",
    "http://i.kinja-img.com/gawker-media/image/upload/iftylroaoeej16deefkn.jpg",
    "http://www.ymcanyc.org/i/ADULTS%20groupspinning2%20FC.jpg",
    "http://www.dogslovewagtime.com/wp-content/uploads/2015/07/Dog-Pictures.jpg",
    "http://cdn.phys.org/newman/gfx/news/hires/2015/earthandmars.png"]
    
    var downloads:[UIImage] = []
    var cellLabels:[String] = []
    
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
            
            for i in 0 ..< self.links.count {
                
                let URL:NSURL = NSURL(string: self.links[i] as! String)!
                let data:NSData = NSData(contentsOfURL: URL)!
                
                print("Beginning download")
                let image:UIImage = UIImage(data: data)!
                NSThread.sleepForTimeInterval(3)
                print("Finished download")
                
                print("Time remaining: ", UIApplication.sharedApplication().backgroundTimeRemaining)
                
                
                let ciImage = CIImage(CGImage: image.CGImage!)
                    
                let options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
                let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: options)
                    
                let faces = faceDetector.featuresInImage(ciImage)
                
                if(faces.count > 0) {
                    
                    let context:CIContext = CIContext(options: nil)
                    let filter: CIFilter = CIFilter(name: "CIGaussianBlur")!
                    filter.setValue(ciImage, forKey: kCIInputImageKey)
                    filter.setValue(5.0, forKey: kCIInputRadiusKey)
                    let result:CIImage = filter.valueForKey(kCIOutputImageKey) as! CIImage
                    
                    let extent:CGRect = result.extent
                    
                    let cgImage: CGImageRef = context.createCGImage(result, fromRect: extent)
                    
                    self.downloads.append(UIImage(CGImage: cgImage))
                    self.cellLabels.append("\(faces.count) face(s) detected")
                }
                else {
                    
                    let context:CIContext = CIContext(options: nil)
                    var filter: CIFilter = CIFilter(name: "CIHueAdjust")!
                    filter.setValue(ciImage, forKey: kCIInputImageKey)
                    filter.setValue(2.0, forKey: kCIInputAngleKey)
                    var result:CIImage = filter.valueForKey(kCIOutputImageKey) as! CIImage
                    
                    filter = CIFilter(name: "CIExposureAdjust")!
                    filter.setValue(result, forKey: kCIInputImageKey)
                    filter.setValue(2.0, forKey: kCIInputEVKey)
                    result = filter.valueForKey(kCIOutputImageKey) as! CIImage
                    
                    let extent:CGRect = result.extent
                    let cgImage: CGImageRef = context.createCGImage(result, fromRect: extent)
                    
                    self.downloads.append(UIImage(CGImage: cgImage))

                    self.cellLabels.append("No faces detected")
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    let indexPath:NSIndexPath = NSIndexPath(forItem: (self.downloads.count-1), inSection: 0)
                    self.downloadsTableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                    
                })
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
        cell.textLabel?.text = self.cellLabels[indexPath.row]
        
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
