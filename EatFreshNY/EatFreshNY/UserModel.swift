//
//  UserModel.swift
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

class UserModel {
   
   static let shared = UserModel()
   private init() {}
   
   // global code to login users
   func login(email: String, password: String, complete: @escaping (Bool) -> ()) {
      FIRAuth.auth()?.signIn(withEmail: email, password: password) { user, error in
         if error == nil {
            print("success")
            complete(true)
         }
      }
   }
   
   // global code to logout users
   func logout() {
      do {
         try FIRAuth.auth()?.signOut()
         print("logout success")
      } catch {
         print(error.localizedDescription)
      }
   }
   
   // global code to logout users
   func checkStoryBoard(storyBoard: String) {
      let sb = UIStoryboard(name: storyBoard, bundle: nil)
      let viewController = sb.instantiateInitialViewController()!
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      appDelegate.window?.rootViewController = viewController
   }
   
   // global code to check if the user is logged in or not
   func checkForLoginUser() {
      FIRDatabase.database().reference(withPath: "users").child(FIRAuth.auth()!.currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot: FIRDataSnapshot) in
         
         let roleSnapshot = snapshot.childSnapshot(forPath: "userRole").value!
         var whichSB: String
         
         if roleSnapshot as! String == "client" {
            whichSB = "Main"
         } else {
            whichSB = "VendorStoryboard2"
         }
            
         self.checkStoryBoard(storyBoard: whichSB)
         
      })
      
   }
}

