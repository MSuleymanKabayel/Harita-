//
//  ViewController.swift
//  Harita
//
//  Created by Süleyman Kabayel on 11/25/24.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapbiew: MKMapView!
    
    @IBOutlet weak var firstText: UITextField!
    @IBOutlet weak var secondText: UITextField!
    
   
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapbiew.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooselocation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 3
        mapbiew.addGestureRecognizer(gestureRecognizer)
 
    }
    
    @objc func chooselocation(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .began {
            
            let touchPoint = gestureRecognizer.location(in: self.mapbiew)
            let coordinate = mapbiew.convert(touchPoint, toCoordinateFrom: mapbiew)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = firstText.text
            annotation.subtitle = secondText.text
            mapbiew.addAnnotation(annotation)
            
            
        }
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        mapbiew.setRegion(region, animated: true)
        
        
    }
    
    @IBAction func saveButon(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newLocation = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context)
        
        newLocation.setValue(firstText.text, forKey: "name")
        newLocation.setValue(secondText.text, forKey: "address")
        newLocation.setValue(mapbiew.centerCoordinate.latitude, forKey: "latitude")
        newLocation.setValue(mapbiew.centerCoordinate.longitude, forKey: "longitude")
        
        do {
            
        }
    }


}

