//
//  WeatherViewController.swift
//  Maps
//
//  Created by Vinay Reddy Polati on 9/20/17.
//  Copyright © 2017 m1m2Solutions. All rights reserved.
//

import UIKit;
struct OpenWeatherAPICallType{
    public static let ByCityName:String = "ByCityName";
    public static let ByZipcode:String = "ByZipcode";
}

class WeatherViewController: UIViewController {
    /* open weather APIKey: 0e9caed61dc46644ae51349c029c16a4 */
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var weatherReportLabel: UILabel!
    
    @IBAction func submitButtonAction(_ sender: Any) {
        if locationTextField.text! != String() {
            if let location = locationTextField.text {
                if let zipcode = Int(location) {
                    if location.characters.count == 5 {
                       print("zipcode: \(zipcode)");
                       weatherData(by: OpenWeatherAPICallType.ByZipcode, value: location);
                    } else {
                        weatherReportLabel.text = " weather there can't be found now, try later"
                    }                    
                } else {
                    weatherData(by: OpenWeatherAPICallType.ByCityName, value: location);
                }
            }
        }
    }
    
    func weatherData(by callBy:String,  value:String){
        var apiCallUrl:String = String();
        if callBy == OpenWeatherAPICallType.ByCityName {
            apiCallUrl = "http://api.openweathermap.org/data/2.5/weather?q="+value.replacingOccurrences(of: " ", with: "%20")+",us&appid=0e9caed61dc46644ae51349c029c16a4";
        } else if callBy == OpenWeatherAPICallType.ByZipcode {
            apiCallUrl = "http://api.openweathermap.org/data/2.5/weather?zip="+value+",us&appid=0e9caed61dc46644ae51349c029c16a4";
        }
        let url = URL(string: apiCallUrl)!;
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error getting data. ");
            } else {
                if let content = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        print(jsonResult);
                        DispatchQueue.main.sync {
                            self.locationTextField.text = jsonResult["name"] as! String;
                            if let desc = ((jsonResult["weather"]  as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                                self.weatherReportLabel.alpha = 1;
                                self.weatherReportLabel.text = desc;
                            }
                        }
                    } catch {
                        print(" Error processing data");
                    }
                }
            }
        }
        task.resume();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Your initialization code here.
        weatherReportLabel.alpha = 0;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: Json structure
    /*
     {
     base = stations;
     clouds =     {
     all = 90;
     };
     cod = 200;
     coord =     {
     lat = "37.53";
     lon = "-121.97";
     };
     dt = 1505951760;
     id = 0;
     main =     {
     humidity = 68;
     pressure = 1012;
     temp = "293.69";
     "temp_max" = "296.15";
     "temp_min" = "291.15";
     };
     name = Fremont;
     sys =     {
     country = US;
     id = 428;
     message = "0.0245";
     sunrise = 1506002111;
     sunset = 1506045944;
     type = 1;
     };
     visibility = 16093;
     weather =     (
     {
     description = "overcast clouds";
     icon = 04d;
     id = 804;
     main = Clouds;
     }
     );
     wind =     {
     deg = 300;
     speed = "3.1";
     };
     }
     */

}
