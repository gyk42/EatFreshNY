//
//  VendorFirebaseFunc.swift
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

class VendorFirebase {
   

   func creatVendor () {
   
      let userRef = FIRDatabase.database().reference(withPath: "user/9gNIhaZJY9PGJdvf5hKLA97TuwO2")
         userRef.observeSingleEvent(of: .value, with: { snapshot in
            })

   }//END func creatVendor
   

   
   
   
   
   
   
}// END of VendorFireBase Class
