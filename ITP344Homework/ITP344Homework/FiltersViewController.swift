//
//  FiltersViewController.swift
//  ITP344Homework
//
//  Created by Dylan Kyle Davis on 2/11/16.
//  Copyright © 2016 Dylan Davis. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController {

    @IBOutlet weak var regularImage: UIImageView!
    @IBOutlet weak var filteredImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetButtonTapped(sender: AnyObject) {
        
        self.filteredImage.image = self.regularImage.image
    }
    
    @IBAction func filterButtonTapped(sender: AnyObject) {
        
        let context:CIContext = CIContext(options: nil)
        let image:CIImage = CIImage(image: self.regularImage.image!)!
        let filter: CIFilter = CIFilter(name: "CISepiaTone")!
        filter.setValue(image, forKey: kCIInputImageKey)
        filter.setValue(0.8, forKey: kCIInputIntensityKey)
        let result:CIImage = filter.valueForKey(kCIOutputImageKey) as! CIImage
        
        let extent:CGRect = result.extent
        
        let cgImage: CGImageRef = context.createCGImage(result, fromRect: extent)
        
        self.filteredImage.image = UIImage(CGImage: cgImage)
    }

    @IBAction func faceRecognizerTapped(sender: AnyObject) {
        
        //let controller:UIImagePickerController = UIImagePickerController()
        
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
