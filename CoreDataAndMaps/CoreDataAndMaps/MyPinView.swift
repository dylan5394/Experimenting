//
//  MyPinView.swift
//  MapKitTest
//
//  Created by Administrator on 3/27/16.
//  Copyright © 2016 ITP. All rights reserved.
//

import UIKit
import MapKit

class MyPinView: MKAnnotationView {
	
	var price : Double?
	
	convenience init(annotation: MKAnnotation?,  price: Double){
		self.init(annotation: annotation, reuseIdentifier: nil)
		self.price = price
		self.annotation = annotation
		self.canShowCallout = true
		self.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
		
		self.image = UIImage(named: "customPin")
		
		self.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
		
		let label : UILabel = UILabel(frame: CGRect(x: 5, y: 8, width: 37, height: 15))
		label.textAlignment = NSTextAlignment.Center
		label.textColor = UIColor.darkGrayColor()
		label.text = "\(price)"
		label.font = UIFont.systemFontOfSize(12, weight: 2)
		self.addSubview(label)
		
	}
	
}
