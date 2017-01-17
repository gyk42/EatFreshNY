//
//  VendorData.swift
//  EatFreshNY
//
//  Created by oskar morett on 1/17/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


class VendorModel {
   
   
   var userID = FIRAuth.auth()?.currentUser?.uid
   var vendorName: String
   var market : String
   var vendorPhone: String
   var vendorLogo : String
   var vendorWebsite: String
   var ref: FIRDatabaseReference?
   
   
   
   init(userID: String, market : String, vendorName: String, vendorPhone: String,vendorLogo : String, vendorWebsite: String){
      self.userID =  userID
      self.vendorName = vendorName
      self.market = market
      self.vendorPhone = vendorPhone
      self.vendorLogo = vendorLogo
      self.vendorWebsite = vendorWebsite
   }
   
   init(snapshot: FIRDataSnapshot) {
      userID = snapshot.key
      let snapshotValue = snapshot.value as! [String: AnyObject]
      market = snapshotValue["market"] as! String
      vendorName = snapshotValue["vendorName"] as! String
      vendorPhone = snapshotValue["vendorPhone"] as! String
      vendorWebsite = snapshotValue["vendorWebsite"] as! String
      vendorLogo = snapshotValue["vendorLogo"] as! String
      ref = snapshot.ref
      
      
   }
   
   
   func toAnyObject() -> [String: AnyObject] {
      return [
         "userID":userID as Any as AnyObject,
         "market": market as String as AnyObject,
         "vendorName" : vendorName as String as AnyObject,
         "vendorPhone": vendorPhone as String as AnyObject,
         "vendorWebsite": vendorWebsite as String as AnyObject,
         "vendorLogo": vendorLogo as String as AnyObject
      ]
   }
   
   
   
   
   
   
}// END Class VEndor



