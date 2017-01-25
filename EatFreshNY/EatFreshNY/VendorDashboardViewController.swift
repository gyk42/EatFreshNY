//
//  VendorDashboardViewController.swift
//  EatFreshNY
//
//  Created by Richel Cuyler on 1/23/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit

class VendorDashboardViewController: UIViewController {
   
   @IBOutlet weak var allProductsQuantity: UILabel!
   @IBOutlet weak var totalRevenue: UILabel!
   @IBOutlet weak var allProductsSold: UILabel!
   
   @IBAction func logoutButton(_ sender: Any) {
      UserModel.shared.logout()
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
}
