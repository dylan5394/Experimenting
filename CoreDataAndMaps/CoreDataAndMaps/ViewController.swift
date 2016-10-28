//
//  ViewController.swift
//  CoreDataAndMaps
//
//  Created by Dylan Kyle Davis on 3/31/16.
//  Copyright © 2016 usc. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var data : [MapItem]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let prefs = NSUserDefaults.standardUserDefaults()
        if (prefs.integerForKey ("dataMigration") == 0){
            
            // migration does not exist
            DataManager.saveData()
            prefs.setInteger(1, forKey: "dataMigration")
            prefs.synchronize()
        }
        
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 34.020404, longitude: -118.286583)
        centerMapOnLocation(initialLocation)

        data = DataManager.getData()
        
        mapView.delegate = self
        mapView.addAnnotations(data)
        
        //		// show artwork on map
        //		let artwork = MapItem(title: "King David Kalakaua",
        //			coordinate: CLLocationCoordinate2D(latitude: 34.020404, longitude: -118.286583))
        //
        //		mapView.addAnnotation(artwork)
        //
        
    }
    
    let regionRadius: CLLocationDistance = 3000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
}

extension ViewController: MKMapViewDelegate {
    
    // 1
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? MapItem {
            let identifier = "pin"
            var view: MyPinView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MyPinView { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 3
                view = MyPinView(annotation: annotation, price: annotation.price!)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                //view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
            }
            return view
        }
        return nil
    }
}
