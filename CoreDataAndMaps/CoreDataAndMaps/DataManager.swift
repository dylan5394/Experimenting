//
//  DataManager.swift
//  MapKitTest
//
//  Created by Administrator on 3/27/16.
//  Copyright © 2016 ITP. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class DataManager: NSObject {
	
	class func saveData() -> (){
	
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // 1
        let fileName = NSBundle.mainBundle().pathForResource("data", ofType: "json");
        let data: NSData? = NSData(contentsOfFile: fileName!)
			
        // 2
        let jsonObject: [String:AnyObject]! = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as! [String:AnyObject]
		
        // 3
		let dataItems = jsonObject["stations"] as! [AnyObject]
		
		for case let dataItem as [String:AnyObject] in dataItems{
			
            
            let entity =  NSEntityDescription.entityForName("Station",
                                                            inManagedObjectContext:managedContext)
            let station = NSManagedObject(entity: entity!,
                                          insertIntoManagedObjectContext: managedContext)
            
            station.setValue(dataItem["station"] as! String, forKey: "station")
            station.setValue(dataItem["notes"] as? String, forKey: "notes")
            station.setValue(dataItem["lat"] as! Double, forKey: "lat")
            station.setValue(dataItem["lng"] as! Double, forKey: "lng")
            station.setValue(dataItem["reg_price"] as? Double, forKey: "reg_price")
			
        }
        
        do {
            try managedContext.save()
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
	}
    
    class func getData() -> [MapItem] {
        
        var data : [MapItem]! = []
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        
        let fetchRequest = NSFetchRequest(entityName: "Station")
 
        var coreDataStuff:[NSManagedObject]?
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
                coreDataStuff = results as? [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        for case let coreDataItem in coreDataStuff! {
            
            let newMapItem:MapItem = MapItem(title: coreDataItem.valueForKey("station") as! String, coordinate: CLLocationCoordinate2D(latitude: coreDataItem.valueForKey("lat") as! Double, longitude: coreDataItem.valueForKey("lng") as! Double))
            newMapItem.price = coreDataItem.valueForKey("reg_price") as? Double
            newMapItem.details = coreDataItem.valueForKey("notes") as? String
            
            data.append(newMapItem)
        }
    
        return data
    }
	

}
