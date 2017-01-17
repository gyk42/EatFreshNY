//
//  VendorSignUpViewController.swift
//  EatFreshNY
//
//  Created by Israel Manzo on 1/14/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit

class VendorSignUpViewController: UIViewController {
   
   //MARK: IBOutlet ------------------------------
   @IBOutlet weak var vendorLogo: UIImageView!
   
   @IBOutlet weak var vendorName: UITextField!
   
   @IBOutlet weak var vendorAddress: UITextField!
   
   @IBOutlet weak var vendorContactEmail: UITextField!
   
   @IBOutlet weak var vendorPhoneNumber: UITextField!
   
   @IBOutlet weak var vendorWebsite: UITextField!
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   //MARK: IBAction ------------------------------
   
   @IBAction func changeLogoPressed(_ sender: Any) {
   
   }
   
   @IBAction func signUpPressed(_ sender: Any) {
   
   }
}
