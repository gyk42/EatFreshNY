//
//  VendorSettingsViewController.swift
//  EatFreshNY
//
//  Created by Yoon Yu on 1/19/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit

class VendorSettingsViewController: UIViewController {
   
   
   
   
/// Outlets   

   
   
   
/// Buttons
   @IBAction func logoutButton(_ sender: Any) {
      
      UserModel.shared.logout()
   }
   
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
