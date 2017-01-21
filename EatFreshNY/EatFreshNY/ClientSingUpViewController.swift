//
//  ClientSingUpViewController.swift
//  EatFreshNY
//
//  Created by Israel Manzo on 1/14/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ClientSingUpViewController: UIViewController {
   
   var ref: FIRDatabaseReference!
   
   //MARK: IBoutlet ---------------------------------
   
   @IBOutlet weak var nameTextField: UITextField!
   
   @IBOutlet weak var emailTextField: UITextField!
   
   @IBOutlet weak var passwordTextField: UITextField!
   
   @IBOutlet weak var phoneNumberTextField: UITextField!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      ref = FIRDatabase.database().reference()
   }
   
   //MARK: IBAction ---------------------------------
   
   @IBAction func signUpPressed(_ sender: Any) {
      if let email = emailTextField.text, let password = passwordTextField.text,
         let phone = phoneNumberTextField.text, let name = nameTextField.text {
         FIRAuth.auth()?.createUser(withEmail: email, password: password)
         {(user, error) in
            if let error = error {
               print(error.localizedDescription)
            } else {
               print("User signed in!")
               
               let currentUserID = FIRAuth.auth()!.currentUser!.uid
               self.ref.child("users").updateChildValues(["\(currentUserID)":["userRole": "client", "userEmail": email, "userLocation" : "0", "userName": name, "userLogo": "0", "userPhoneNumber": phone, "userWebsite": "0"]])
               
               UserModel.shared.user = User(userID: currentUserID, userRole: "client", userEmail: email, userLocation: "0", userName: name, userPhoneNumber: phone, userWebsite: "0", userLogo: "")
               
               UserModel.shared.checkStoryBoard(storyBoard: "Main")
            }
         }
      } else {
         print("You left email/password empty")
      }
   }
}
