//
//  ThankYouPurchaseConfirmationPageViewController.swift
//  EatFreshNY
//
//  Created by Matt Tripodi on 1/14/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit

class ThankYouPurchaseConfirmationPageViewController: UIViewController {
   
   // MARK: @IBOutlet --------------------------------------------
   
   @IBOutlet weak var cartIDLabel: UILabel!
   @IBOutlet weak var estimatedPickUpTimeLabel: UILabel!
   
   // MARK: IBActions --------------------------------------------
   
   @IBAction func continueShoppingButtonTapped(_ sender: Any) {
   }

   override func viewDidLoad() {
      super.viewDidLoad()
   }
}
