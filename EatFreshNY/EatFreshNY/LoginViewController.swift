//
//  LoginViewController.swift
//  EatFreshNY
//
//  Created by Israel Manzo on 1/14/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
   
   // MARK: IBOutlet -------------------------------
   
   @IBOutlet weak var clientNameTextField: UITextField!
   
   @IBOutlet weak var clientNamePassword: UITextField!

   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   // MARK: IBAction -------------------------------
   
   @IBAction func loginBtnPressed(_ sender: Any) {
      let userLoginEmail = clientNameTextField.text!
      let userLoginPassword = clientNamePassword.text!
      
      UserModel.shared.login(email: userLoginEmail, password: userLoginPassword) { success in
         
         // TODO: handle success
         if success {
            self.performSegue(withIdentifier: "dummyViewController", sender: self)
         } else {
            print("error in login")
         }
      }
   }
}
