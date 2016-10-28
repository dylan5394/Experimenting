//
//  ImageDownloadViewController.swift
//  ITP344Homework
//
//  Created by Dylan Kyle Davis on 4/14/16.
//  Copyright © 2016 Dylan Davis. All rights reserved.
//

import Alamofire
import UIKit
import MBProgressHUD
import AFDropdownNotification

class ImageDownloadViewController: UIViewController, AFDropdownNotificationDelegate {

    var notification:AFDropdownNotification?
    var downloadedImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func downloadImage(sender: AnyObject) {
    
        Alamofire.request(.GET, "http://alidev.usc.edu/ali2/wp-content/uploads/2014/10/Fountain.jpg")
            .response { request, response, data, error in
                
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                
                self.downloadedImage = UIImage(data: data!)
                
                self.notification = AFDropdownNotification()
                self.notification!.notificationDelegate = self
                self.notification!.titleText = "Image finished downloading"
                self.notification!.subtitleText = "Do you want to open the image?"
                self.notification!.topButtonText = "Open"
                self.notification!.bottomButtonText = "Cancel"
                self.notification!.presentInView(self.view, withGravityAnimation: true)

        }
        
        let hud:MBProgressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "Loading...";
        
    }
    
    @IBAction func reportError(sender: AnyObject) {
        
        var crash:String?
        let crashNow:String = crash!
    }
    
    func dropdownNotificationTopButtonTapped() {
    
        notification?.dismissWithGravityAnimation(true)
     
        self.performSegueWithIdentifier("showImage", sender: self)
    }
    
    func dropdownNotificationBottomButtonTapped() {
    
        notification?.dismissWithGravityAnimation(true)
        downloadedImage = nil
    }
    
    //MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let dest:DownloadedImageViewController = segue.destinationViewController as! DownloadedImageViewController
        dest.image = self.downloadedImage
    }
    

}
