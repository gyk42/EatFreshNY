//
//  UserDataModel.swift
//  EatFreshNY
//
//  Created by Yoon Yu on 1/18/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class User {
   
   var userID = FIRAuth.auth()?.currentUser?.uid
   var userEmail: String
   var userRole: String
   var userLocation : String
   var userName: String
   var userPhoneNumber: String
   var userWebsite: String
   var userLogo: String
   var ref: FIRDatabaseReference?

   var userDescription: String
   var ref: FIRDatabaseReference?
   
   init(userID: String, userRole: String, userEmail: String, userLocation: String, userName: String,userPhoneNumber : String, userWebsite: String, userLogo: String, userDescription: String){
      self.userID =  userID
      self.userEmail = userEmail
      self.userRole = userRole
      self.userLocation = userLocation
      self.userName = userName
      self.userPhoneNumber = userPhoneNumber
      self.userWebsite = userWebsite
      self.userLogo = userLogo
      self.userDescription = userDescription
   }
   
   init(snapshot: FIRDataSnapshot) {
      userID = snapshot.key
      let snapshotValue = snapshot.value as! [String: AnyObject]
      userEmail = snapshotValue["userEmail"] as! String
      userRole = snapshotValue["userRole"] as! String
      userLocation = snapshotValue["userLocation"] as! String
      userName = snapshotValue["userName"] as! String
      userPhoneNumber = snapshotValue["userPhoneNumber"] as! String
      userWebsite = snapshotValue["userWebsite"] as! String
      userLogo = snapshotValue["userLogo"] as! String
      userDescription = snapshotValue["userDescription"] as! String
      ref = snapshot.ref
   }
   
   func toAnyObject() -> [String: AnyObject] {
      return [
         "userID":userID as Any as AnyObject,
         "userEmail": userEmail as String as AnyObject,
         "userRole" : userRole as String as AnyObject,
         "userLocation": userLocation as String as AnyObject,
         "userName": userName as String as AnyObject,
         "userPhoneNumber": userPhoneNumber as String as AnyObject,
         "userWebsite": userWebsite as String as AnyObject,
         "userLogo": userLogo as String as AnyObject
         "userDescription": userDescription as String as AnyObject
      ]
   }
}

