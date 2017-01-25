//
//  SelectProductCategoryTableViewPageViewController.swift
//  EatFreshNY
//
//  Created by Matt Tripodi on 1/17/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit

class SelectProductCategoryTableViewPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
   var productCategoryImageArray: [String] = ["baked-goods", "dairy", "fruits", "preserves", "fish", "meat"]
   
   // IBOutlets --------------------------------------------------
   
   @IBOutlet weak var selectProductCategoryTableView: UITableView!
   
   // TableView --------------------------------------------------
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 6
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      self.performSegue(withIdentifier: "ToCollection", sender: productCategoryImageArray[indexPath.row])
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! SelectProductTableViewCell
      cell.ProductCategoryImageOutlet.image = UIImage(named:self.productCategoryImageArray[indexPath.row])
      return cell
   }
   
   // override functions --------------------------------------------
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "ToCollection" {
         let destination = segue.destination as! AllProductCollectionViewPageViewController
         AllProductCollectionViewPageViewController.selectedProductValue = sender as? String
         AllProductCollectionViewPageViewController.selectedProductKey = "category"
      }
   }
   
   // IBActions -------------------------------------------------
   
   @IBAction func logOutButtonTapped(_ sender: Any) {
      UserModel.shared.logout()
   }
}
