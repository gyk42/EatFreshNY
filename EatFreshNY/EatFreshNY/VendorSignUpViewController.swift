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

   //MARK: IBAction ------------------------------
   
   @IBAction func signUpPressed(_ sender: Any) {
      if let email = vendorContactEmail.text, let password = vendorPassword.text, let location = vendorAddress.text, let name = vendorName.text,
         let phone = vendorPhoneNumber.text, let website = vendorWebsite.text {
         FIRAuth.auth()?.createUser(withEmail: email, password: password)
         {(user, error) in
            if let error = error {
               print(error.localizedDescription)
            } else {
               print("User signed in!")
               let currentUserID = FIRAuth.auth()!.currentUser!.uid
           
               self.ref.child("users").updateChildValues(["\(currentUserID)":["userRole": "vendor", "userEmail": email, "userLocation" : location, "userName" : name, "userPhoneNumber": phone, "userWebsite": website, "userDescription": "0"]])
               UserModel.shared.user = User(userID: currentUserID , userRole: "vendor", userEmail: email, userLocation: location, userName: name, userPhoneNumber: phone, userWebsite: website, userDescription: "0")				
               UserModel.shared.checkStoryBoard(storyBoard: "VendorStoryboard2")         
				}
         }
			
      } else {
         print("You left email/password empty")
      }

   }
}
