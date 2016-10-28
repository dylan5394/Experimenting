//
//  GCDTestViewController.swift
//  ITP344Homework
//
//  Created by Dylan Kyle Davis on 2/4/16.
//  Copyright © 2016 Dylan Davis. All rights reserved.
//

import UIKit

class GCDTestViewController: UIViewController {

    let workQueue:dispatch_queue_t = dispatch_queue_create("myQueue", nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ApplyPressed(sender: AnyObject) {
        
        
    }
    
    @IBAction func SynchPressed(sender: AnyObject) {
        
        
    }
    
    @IBAction func AsynchPressed(sender: AnyObject) {
        
        
    }
    
    func performTask(taskNum: Int) -> Void {
        
        NSThread.sleepForTimeInterval(1)
        print("Thread %i", taskNum)
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
