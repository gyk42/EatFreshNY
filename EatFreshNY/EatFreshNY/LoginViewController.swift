//
//  LoginViewController.swift
//  EatFreshNY
//
//  Created by Israel Manzo on 1/14/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
   
   // MARK: IBOutlet -------------------------------
   
   @IBOutlet weak var clientNameTextField: UITextField!
   
   @IBOutlet weak var clientNamePassword: UITextField!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      checkForCurrentUser()
   }
   
   func checkForCurrentUser() {
      if FIRAuth.auth()?.currentUser != nil {
         //checkForLoginUser()
      }
   }
   
   func checkForLoginUser() {
      FIRDatabase.database().reference(withPath: "users").child(FIRAuth.auth()!.currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot: FIRDataSnapshot) in
         
         let roleSnapshot = snapshot.childSnapshot(forPath: "userRole").value!
         
         var whichSB: String
         
         if roleSnapshot as! String == "client" {
            whichSB = "Main"
         } else {
            whichSB = "VendorStoryboard2"
         }
         
         UserModel.shared.checkStoryBoard(storyBoard: whichSB)
         
      })
      
   }
   // MARK: IBAction -------------------------------
   
   @IBAction func loginBtnPressed(_ sender: Any) {
      let userLoginEmail = clientNameTextField.text!
      let userLoginPassword = clientNamePassword.text!
      
      // TODO
      
      UserModel.shared.login(email: userLoginEmail, password: userLoginPassword) { success in
         
         // TODO: handle success
         if success {
            self.checkForLoginUser()
         } else {
            print("error in login")
         }
      }
   }
}
