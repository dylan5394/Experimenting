//
//  DownloadedImageViewController.swift
//  ITP344Homework
//
//  Created by Dylan Kyle Davis on 4/14/16.
//  Copyright © 2016 Dylan Davis. All rights reserved.
//

import UIKit

class DownloadedImageViewController: UIViewController {

    var image:UIImage?
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView.image = self.image!;
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
