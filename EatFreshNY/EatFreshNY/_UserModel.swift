//
//  UserModel.swift
//  practiceWithFB
//
//  Created by Yoon Yu on 1/16/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

//import Foundation
//import Firebase
//import FirebaseAuth
//import FirebaseDatabase
//
//class UserModel {
//   static let shared = UserModel()
//   private init() {}
//   
//   //var role: Role = .none
//   
//   func login(email: String, password: String, complete: @escaping (Bool) -> ()) {
//      FIRAuth.auth()?.signIn(withEmail: email, password: password) { user, error in
//         if error == nil {
//            print("success")
//            complete(true)
//         }
//      }
//   }
//   
//   func logout() {
////      role = .none
//      do {
//         try FIRAuth.auth()?.signOut()
//         print("logout success")
//      } catch {
//         print(error.localizedDescription)
//      }
//   }
//}

//enum Role {
//   case vendor
//   case client
//   case none
//   
//   var value: String {
//      switch self {
//      case .vendor:
//         return "vendor"
//      case .client:
//         return "client"
//      case .none:
//         return "none"
//      }
//   }
//   
//   var buttonText: String {
//      switch self {
//      case .vendor, .client:
//         return "Sign up"
//      case .none:
//         return "Log in"
//      }
//   }
//   
//   var title: String {
//      switch self {
//      case .vendor:
//         return "Vendor"
//      case .client:
//         return "Client"
//      case .none:
//         return "Login"
//      }
//   }
//   
//   mutating func update(value: String) {
//      switch value {
//      case "vendor":
//         self = .vendor
//      case "client":
//         self = .client
//      default:
//         self = .none
//         
//      }
//   }
//}
