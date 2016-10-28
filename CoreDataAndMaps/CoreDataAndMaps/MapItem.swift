//
//  MapItem.swift
//  MapKitTest
//
//  Created by Administrator on 3/27/16.
//  Copyright © 2016 ITP. All rights reserved.
//

import UIKit
import MapKit

class MapItem: NSObject, MKAnnotation {
	
	let title: String?
	let coordinate: CLLocationCoordinate2D
	var price: Double?
	var details: String?
 
	init(title: String, coordinate: CLLocationCoordinate2D) {
		self.title = title
		self.coordinate = coordinate
		super.init()
		
	}
 
	var subtitle: String? {
		return details
	}
	

}
