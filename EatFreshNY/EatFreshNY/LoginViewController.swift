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
      // UserModel.shared.logout()
   }
   
   func checkForCurrentUser() {
      if FIRAuth.auth()?.currentUser != nil {
         UserModel.shared.checkForLoginUser()
         //checkForLoginUser()
      }
   }
   
   // to get rid of keyboard by touching the outside of the textfield
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
   }
   
   // MARK: IBAction -------------------------------
   
   @IBAction func loginBtnPressed(_ sender: Any) {
      let userLoginEmail = clientNameTextField.text!
      let userLoginPassword = clientNamePassword.text!
      
      let userDescription = "0"
      // TODO
      
      UserModel.shared.login(email: userLoginEmail, password: userLoginPassword, complete: { success in
         if success {
            UserModel.shared.checkForLoginUser()
         } else {
            let alertController = UIAlertController(title: "Error", message: "Please provide a valid email or password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
         }
      })
   }
}
