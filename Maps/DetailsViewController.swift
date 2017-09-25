//
//  DetailsViewController.swift
//  Maps
//
//  Created by Vinay Reddy Polati on 9/19/17.
//  Copyright © 2017 m1m2Solutions. All rights reserved.
//

import UIKit;
import CoreData;

class DetailsViewController: UIViewController {
    var _currentUser:User?;
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        
    }
    
    
    @IBAction func updateInfoButtonAction(_ sender: Any) {
        let appDomain = UIApplication.shared.delegate as! AppDelegate;
        let context = appDomain.persistentContainer.viewContext;
        let request =  NSFetchRequest<NSFetchRequestResult>(entityName:"Users");
        request.returnsObjectsAsFaults = false;
        request.predicate = NSPredicate(format: "\(UserKeys.userName) = %@", _currentUser!.userName);
        do {
            let results = try context.fetch(request);
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                        if userNameTextField.text! !=  String() {
                              result.setValue(userNameTextField.text!, forKey: UserKeys.userName);
                        }
                        if passwordTextField.text! != String() {
                            result.setValue(passwordTextField.text!, forKey: UserKeys.password);
                        }
                        if mobileNumberTextField.text! != String() {
                            result.setValue(Int64(mobileNumberTextField.text!)!, forKey: UserKeys.mobileNumber);
                        }
                        if emailTextField.text! != String() {
                            result.setValue(emailTextField.text! , forKey: UserKeys.email);
                        }
                }
                do {
                    try context.save();
                    print(" information successfully updated! ");
                } catch {
                    print(" Error updating record. ");
                }
            } else {
                print(" No records to update. ");
            }
        } catch {
            print(" Failed to update record. ");
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let currentUser = _currentUser {
            print("[ username: \(currentUser.userName), password: \(currentUser.password), mobileNumber: \(currentUser.mobileNumber), email: \(currentUser.emailId) ]");
            userNameTextField.text = _currentUser!.userName;
            passwordTextField.text = _currentUser!.password;
            mobileNumberTextField.text = String(describing: _currentUser!.mobileNumber) ;
            emailTextField.text = _currentUser!.emailId;
        } else {
            print(" currentUser is nil. ");
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
