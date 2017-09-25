//
//  User.swift
//  Maps
//
//  Created by Vinay Reddy Polati on 9/19/17.
//  Copyright © 2017 m1m2Solutions. All rights reserved.
//

import Foundation

class UserKeys {
    public static let userName:String = "userName";
    public static let password:String = "password";
    public static let mobileNumber = "mobileNumber";
    public static let email = "emailId";
}
class User {
    
    let userName:String;
    let password:String;
    let mobileNumber:Int64;
    let emailId:String;
    
    // Mark: initializer
    init(userName:String, password:String, mobileNumber:Int64, email:String){
        self.userName = userName;
        self.password = password;
        self.mobileNumber = mobileNumber;
        self.emailId = email;
    }
}
