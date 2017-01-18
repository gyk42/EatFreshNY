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
   
   func login(email: String, password: String, complete: @escaping (Bool) -> ()) {
      FIRAuth.auth()?.signIn(withEmail: email, password: password) { user, error in
         if error == nil {
            print("success")
            complete(true)
         }
      }
   }
   
   func logout() {
      do {
         try FIRAuth.auth()?.signOut()
         print("logout success")
      } catch {
         print(error.localizedDescription)
      }
   }
   
   func checkStoryBoard(storyBoard: String) {
      let sb = UIStoryboard(name: storyBoard, bundle: nil)
      let viewController = sb.instantiateInitialViewController()!
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      appDelegate.window?.rootViewController = viewController
   }
}

