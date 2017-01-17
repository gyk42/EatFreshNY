//
//  ClientSingUpViewController.swift
//  EatFreshNY
//
//  Created by Israel Manzo on 1/14/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit

class ClientSingUpViewController: UIViewController {
   
   //MARK: IBoutlet ---------------------------------
   
   @IBOutlet weak var firstNameTextField: UITextField!
   
   @IBOutlet weak var lastNameTextField: UITextField!
   
   @IBOutlet weak var emailTextField: UITextField!
   
   @IBOutlet weak var phoneNumberTextField: UITextField!
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   //MARK: IBAction ---------------------------------
   
   @IBAction func signUpPressed(_ sender: Any) {
   }
   
   
}
