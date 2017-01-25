//
//  ClientData.swift
//  EatFreshNY
//
//  Created by oskar morett on 1/17/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class ClientModel {
   var userID = FIRAuth.auth()?.currentUser?.uid
   var clientName: String
   var clientPhone: String
   var cleintEmail: String
   var ref: FIRDatabaseReference?
   
   init(userID: String, clientName : String, clientPhone: String, cleintEmail: String){
      self.userID =  userID
      self.clientName = clientName
      self.clientPhone = clientPhone
      self.cleintEmail = cleintEmail
   }
   
   init(snapshot: FIRDataSnapshot) {
      userID = snapshot.key
      let snapshotValue = snapshot.value as! [String: AnyObject]
      clientName = snapshotValue["clientName"] as! String
      clientPhone = snapshotValue["clientPhone"] as! String
      cleintEmail = snapshotValue["cleintEmail"] as! String
      ref = snapshot.ref
   }
   
   func toAnyObject() -> [String: AnyObject] {
      return [
         "userID":userID as Any as AnyObject,
         "clientName": clientName as String as AnyObject,
         "clientPhone" : clientPhone as String as AnyObject,
         "cleintEmail": cleintEmail as String as AnyObject
      ]
   }
}
