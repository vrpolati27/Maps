//
//  ViewController.swift
//  Maps
//
//  Created by Vinay Reddy Polati on 9/16/17.
//  Copyright © 2017 m1m2Solutions. All rights reserved.
//

import UIKit;
import MapKit;
import CoreLocation;

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    var locationManager = CLLocationManager();
    
    private func setupMap(latitude lat:CLLocationDegrees, longitude long:CLLocationDegrees){
        /* Empire State Building
         New York, NY 10001
         40.748692, -73.985675 */
        let latitude:CLLocationDegrees = lat;
        let longitude:CLLocationDegrees = long;
        let latDelta:CLLocationDegrees = 0.05; let longDelta:CLLocationDegrees = 0.05;
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta);
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude);
        let region = MKCoordinateRegionMake(location, span);
        map.setRegion(region, animated: true);
        
        /* Adding annotation. */
//        let annotation = MKPointAnnotation();
//        annotation.title = "Empire State Building";
//        annotation.subtitle = "One day I would go there";
//        annotation.coordinate = location;
//        map.addAnnotation(annotation)
    }
    
    
    @objc func longpress(gr:UILongPressGestureRecognizer){
        let touchpoint = gr.location(in: self.map);
        let coordinate = map.convert(touchpoint, toCoordinateFrom: self.map);
        let annotation = MKPointAnnotation();
        annotation.coordinate = coordinate;
        annotation.title = "New Place";
        annotation.subtitle = "I have to go here."
        map.addAnnotation(annotation);
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations);
        let userLocation:CLLocation = locations[0];
        let latitude = userLocation.coordinate.latitude;
        let longitude = userLocation.coordinate.longitude;
        print("latitude: \(latitude) and longitude: \(longitude)");
        setupMap(latitude: latitude, longitude: longitude);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view, typically from a nib.
//        setupMap(latitude: 40.748692, longitude: -73.985675);
//        let uilpgr =  UILongPressGestureRecognizer(target: self, action: #selector(self.longpress(gr:)) )
//        uilpgr.minimumPressDuration = 1;
//        map.addGestureRecognizer(uilpgr);
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

