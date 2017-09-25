//
//  ImagesViewController.swift
//  Maps
//
//  Created by Vinay Reddy Polati on 9/20/17.
//  Copyright © 2017 m1m2Solutions. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var categories:[String] = ["Category1","Category2","Category2", "Category4","Category5","Default"];
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var urlTextField: UITextField!
    /*@IBOutlet weak var tableView: UITableView!*/
    
    @IBOutlet weak var image: UIImageView!
    @IBAction func downloadButtonAction(_ sender: Any) {
        if let urlString = urlTextField.text {
            if urlString != String(){
                let url = URL(string: urlString)!;
                let request = NSMutableURLRequest(url: url);
                
                let task = URLSession.shared.dataTask(with: request as! URLRequest, completionHandler: { (data, response, error) in
                    if error != nil {
                        print(" Error downloading image. ");
                    } else {
                        if let content = data {
                            if let image = UIImage(data: content) {
                               DispatchQueue.main.async(execute: {
                                  /* update UserInterface. */
                               })
                                /* save image locally. */
                                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true);
                                print("Documents path: \(documentsPath)");
                                if documentsPath.count > 0 {
                                    let savepath = documentsPath[0] + "/image1.jpg";
                                    do{
                                        try UIImageJPEGRepresentation(image, 1)?.write(to: URL(fileURLWithPath: savepath));
                                        print("congratulations! image successfully saved locally.");
                                        self.urlTextField.text = String();
                                    } catch {
                                        print(" Error saving image locally. ");
                                    }
                                }
                            }
                        }
                    }
                })
                task.resume();
            }
        }
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row];
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel;
        if(pickerLabel == nil){
            pickerLabel = UILabel();
            pickerLabel?.text = categories[row];
            pickerLabel?.font = UIFont(name: "Avenir-Medium", size: 20.0);
            pickerLabel?.textAlignment = NSTextAlignment.center;
            pickerLabel?.textColor = UIColor.orange;
        }
        return pickerLabel!;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        // Do any additional setup after loading the view.
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true);
        if documentsPath.count > 0 {
            let savepath = documentsPath[0] + "/image1.jpg";
            image.image = UIImage(contentsOfFile: savepath);
        }
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
