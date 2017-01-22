//
//  VendorSignUpViewController.swift
//  EatFreshNY
//
//  Created by Israel Manzo on 1/14/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class VendorSignUpViewController: UIViewController {
   
   var ref: FIRDatabaseReference!
   
   //MARK: IBOutlet ------------------------------
   
   @IBOutlet weak var vendorName: UITextField!
   
   @IBOutlet weak var vendorAddress: UITextField!
   
   @IBOutlet weak var vendorContactEmail: UITextField!
   
   @IBOutlet weak var vendorPhoneNumber: UITextField!
   
   @IBOutlet weak var vendorPassword: UITextField!
   
   @IBOutlet weak var vendorWebsite: UITextField!
   
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
   
   //MARK: IBAction ------------------------------
   
   @IBAction func signUpPressed(_ sender: Any) {
      let name = vendorName.text!
      let location = vendorAddress.text!
      let email = vendorContactEmail.text!
      let password = vendorPassword.text!
      let phone = vendorPhoneNumber.text!
      let website = vendorWebsite.text!
      
      // Validation for textfields
      if name == "" {
         alert(message: "name")
      } else if location == "" {
         alert(message: "address")
      } else if email == "" {
         alert(message: "email")
      } else if password == "" {
         alert(message: "password")
      } else if phone == "" {
         alert(message: "phone")
      } else if website == "" {
         alert(message: "website")
      } else {
         FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            // Checks to see if user exists
            if let error = error {
               // using a seperate alert controller because message is different
               let alertController = UIAlertController(title: "User exists.", message: "Please use another email or sign in.", preferredStyle: UIAlertControllerStyle.alert)
               let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
               alertController.addAction(defaultAction)
               self.present(alertController, animated: true, completion: nil)
               print(error.localizedDescription)
            } else {
               
               let currentUserID = FIRAuth.auth()!.currentUser!.uid
               self.ref.child("users").updateChildValues(["\(currentUserID)":["userRole": "vendor", "userEmail": email, "userLocation" : location, "userName" : name, "userPhoneNumber": phone, "userWebsite": website, "userDescription": "0", "userLogo": "0"]])
               UserModel.shared.user = User(userID: currentUserID , userRole: "vendor", userEmail: email, userLocation: location, userName: name, userPhoneNumber: phone, userWebsite: website, userLogo: "0", userDescription: "0")
               UserModel.shared.checkStoryBoard(storyBoard: "VendorStoryboard2")
               print("User signed in!")
            }
         }
      }
   }
}
