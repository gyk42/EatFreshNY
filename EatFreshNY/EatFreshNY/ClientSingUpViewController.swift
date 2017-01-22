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
   
   // to get rid of keyboard by touching the outside of the textfield
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
   }
   
   // function for alerts
   func alert(message: String) {
      let alertController = UIAlertController(title: "\(message.capitalized) is a required field" , message: "Please enter your \(message)", preferredStyle: .alert)
      let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
      alertController.addAction(defaultAction)
      self.present(alertController, animated: true, completion: nil)
   }
   
   //MARK: IBAction ---------------------------------
   
   @IBAction func signUpPressed(_ sender: Any) {
      let email = emailTextField.text!
      let password = passwordTextField.text!
      let phone = phoneNumberTextField.text!
      let name = nameTextField.text!
      
      // Validation for textfields
      if name == "" {
         alert(message: "full name")
      } else if email == "" {
         alert(message: "email address")
      } else if password == "" {
         alert(message: "password")
      } else if phone == "" {
         alert(message: "number")
      } else {
         
         
         FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            // Checks to see if user exists
            if let error = error {
               let alertController = UIAlertController(title: "User exists.", message: "Please use another email or sign in.", preferredStyle: UIAlertControllerStyle.alert)
               let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
               alertController.addAction(defaultAction)
               self.present(alertController, animated: true, completion: nil)
               print(error.localizedDescription)
            } else {
               let currentUserID = FIRAuth.auth()!.currentUser!.uid
               self.ref.child("users").updateChildValues(["\(currentUserID)":["userRole": "client", "userEmail": email, "userLocation" : "0", "userName": name, "userPhoneNumber": phone, "userWebsite": "0", "userDescription": "0", "userLogo": "0"]])
               UserModel.shared.user = User(userID: currentUserID, userRole: "client", userEmail: email, userLocation: "0", userName: name, userPhoneNumber: phone, userWebsite: "0", userLogo: "0", userDescription: "0")
               UserModel.shared.checkStoryBoard(storyBoard: "Main")
               print("User signed in!")
            }
         }
      }
   }
}

