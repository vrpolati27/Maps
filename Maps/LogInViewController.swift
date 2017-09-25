//
//  LogInViewController.swift
//  Maps
//
//  Created by Vinay Reddy Polati on 9/19/17.
//  Copyright © 2017 m1m2Solutions. All rights reserved.
//

import UIKit;
import CoreData;

class LogInViewController: UIViewController {
 
    var usersList:[User] = [];
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBAction func loginButtonAction(_ sender: Any) {
        displayLabel.text = String();
        var userFound:Bool = false;
       /* databaseInformation(at: "Users");*/
        for user in usersList {
            if user.userName == userNameTextField.text ?? String() &&
                user.password == passwordTextField.text ?? String() {
                displayLabel.text = " Hello \(user.userName) You are successfully logged in. ";
                userFound = true;
                /* seguing to DetailViewController.*/
                let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
                let vc = storyBoard.instantiateViewController(withIdentifier: "newvc") as! DetailsViewController
                 vc._currentUser = user;
                self.present(vc, animated: true, completion: {
                   /* some code.*/
                })
                break;
            }
        }
        if !userFound {
            displayLabel.text = " Hello dear customer there are no records matching that information, try entering correct username and password.  ";
        }
        
    }
    
    
    @IBAction func signupButtonAction(_ sender: Any) {
        displayLabel.text = String();
        if userNameTextField.text != String() {
            if passwordTextField.text != String() {
                if mobileNumberTextField.text != String() {
                    if emailTextField.text != String() {
                        insert2Db_Users(userName: userNameTextField.text!, password: passwordTextField.text!, mobileNumber: Int64(mobileNumberTextField.text!) ?? 1234567890, email: emailTextField.text!);
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        databaseInformation(at: "Users");
        for user in usersList {
            print("[ username: \(user.userName), password: \(user.password), mobile: \(user.mobileNumber), email: \(user.emailId)]");
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insert2Db_Users( userName:String, password:String, mobileNumber:Int64, email:String) {
        let appDomain = UIApplication.shared.delegate as! AppDelegate;
        let context = appDomain.persistentContainer.viewContext;
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context);
        newUser.setValue(userName, forKey: UserKeys.userName);
        newUser.setValue(password, forKey: UserKeys.password);
        newUser.setValue(mobileNumber, forKey: UserKeys.mobileNumber);
        newUser.setValue(email, forKey: UserKeys.email);
        usersList.append(User(userName: userName, password: password, mobileNumber: mobileNumber, email: email));
        do {
            try context.save();
            print("record successfully inserted. ");
            displayLabel.text = " congartulations! \(userName), your account successfully created. ";
        } catch {
            print( " oops! sorry \(userName), can't singnup now try later. ");
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func databaseInformation(at entity:String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
        
        /* Fetch records.*/
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity);
        request.returnsObjectsAsFaults = false;
        do {
            let results = try context.fetch(request);
            if (results.count > 0 ) {
                for result in results as! [NSManagedObject] {
                    let _user:User = User(userName: result.value(forKey: UserKeys.userName) as! String, password: result.value(forKey: UserKeys.password) as! String, mobileNumber: result.value(forKey: UserKeys.mobileNumber) as! Int64, email: result.value(forKey: UserKeys.email) as! String);
                    usersList.append(_user);
                }
            } else {
                print( " There are no records in \(entity) Table");
            }
        } catch {
            print(" Error reading records from entity \(entity)");
        }
    }

}
