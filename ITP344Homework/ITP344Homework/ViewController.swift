//
//  ViewController.swift
//  ITP344Homework
//
//  Created by Dylan Kyle Davis on 1/21/16.
//  Copyright © 2016 Dylan Davis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var animator: UIDynamicAnimator?
    let gravity: UIGravityBehavior = UIGravityBehavior()
    let collision: UICollisionBehavior = UICollisionBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        animator = UIDynamicAnimator(referenceView: view)
        animator!.addBehavior(gravity)
        
        collision.translatesReferenceBoundsIntoBoundary = true
        animator!.addBehavior(collision)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func CreateAndDrop(sender: AnyObject) {
    
        let xValue = Int(arc4random_uniform(400))
        let newBall: UIView = UIView(frame: CGRectMake((CGFloat)(xValue), 0, 50, 50))
        
        newBall.backgroundColor = UIColor.orangeColor()
        newBall.layer.cornerRadius=25
        self.view.addSubview(newBall)
        
        gravity.addItem(newBall)
        collision.addItem(newBall)

    }

}

