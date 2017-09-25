//
//  LocationInfoViewController.swift
//  Maps
//
//  Created by Vinay Reddy Polati on 9/17/17.
//  Copyright © 2017 m1m2Solutions. All rights reserved.
//

import UIKit;
import CoreLocation;

class LocationInfoViewController: UIViewController, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager();
    
    @IBOutlet weak var latitudeTextField: UILabel!
    @IBOutlet weak var longitudeTextField: UILabel!
    @IBOutlet weak var courseTextField: UILabel!
    @IBOutlet weak var speedTextField: UILabel!
    @IBOutlet weak var altitudeTextField: UILabel!
    @IBOutlet weak var addressTextField: UILabel!
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0];
        let latitude = userLocation.coordinate.latitude;
        let longitude = userLocation.coordinate.longitude;
        latitudeTextField.text = "Latitude:  " + String(latitude);
        longitudeTextField.text = "Longitude:  " + String(longitude);
        let speed = userLocation.speed;
        speedTextField.text = "Speed:  " + String(speed);
        let course = userLocation.course;
        courseTextField.text = "Course(direction):  " + String(course);
        altitudeTextField.text = "Altitude:  " + String(userLocation.altitude);
        
        /* Getting Address*/
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if let err = error {
                print(" Error information: \(err)");
            } else {
                if let placemark = placemarks?[0] {
                              var address = String();
                              let country = placemark.country ?? String();
                              let zipcode = placemark.postalCode ?? String();
                              let subThroughfare = placemark.subThoroughfare ?? String();
                              let throughfare = placemark.subThoroughfare ?? String();
                              let subLocality = placemark.subLocality ?? String();
                    let subAdminArea = placemark.subAdministrativeArea ?? String();
                    let adminArea = placemark.administrativeArea ?? String();
                    print("subThroughfare: \(subThroughfare), throughfare: \(throughfare), subLocality: \(subLocality), subAdminArea: \(subAdminArea), AdminArea: \(adminArea), zipcode: \(zipcode), country: \(country)");
                    address = "\(throughfare) \(subAdminArea) \n \(adminArea),  \(zipcode) \n  \(country)   )";
                    self.addressTextField.text = address;
                } else {
                    self.addressTextField.text = "oops! No address associated with this GeoInfo";
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        // Do any additional setup after loading the view.
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
