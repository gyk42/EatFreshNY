//
//  ProductDetailPageViewController.swift
//  EatFreshNY
//
//  Created by Matt Tripodi on 1/14/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ProductDetailPageViewController: UIViewController {
   
   var ref: FIRDatabaseReference!
   
   // MARK: IBOutlets ----------------------------------
   @IBOutlet weak var productDetailImage: UIImageView!
   @IBOutlet weak var productNameLabel: UILabel!
   @IBOutlet weak var productDescriptionLabel: UILabel!
   @IBOutlet weak var productPriceLabel: UILabel!
   @IBOutlet weak var quantityNumberLabel: UILabel!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      let userRef = FIRDatabase.database().reference(withPath: "products/-KaoLdcYr2iI75Ycs8fD")
      userRef.observeSingleEvent(of: .value, with: { (snapshot) in
         if snapshot.hasChildren(){
            let productNameLabel = snapshot.childSnapshot(forPath: "name").value as! String
            let productDescriptionLabel = snapshot.childSnapshot(forPath: "description").value as! String
            let productPriceLabel = snapshot.childSnapshot(forPath: "price").value as! String
            let quantityNumberLabel = snapshot.childSnapshot(forPath: "quantity").value as! String
            //let productDetailImage = snapshot.childSnapshot(forPath: "image").value as! Data
            
            self.productNameLabel.text = productNameLabel
            self.productDescriptionLabel.text = productDescriptionLabel
            self.productPriceLabel.text = productPriceLabel
            self.quantityNumberLabel.text = quantityNumberLabel
            //self.productDetailImage.image = productDetailImage
         }
         
         
      })
      
      
   }
   
   // MARK: IBActions ----------------------------------
   
   @IBAction func addToCartButtonTapped(_ sender: UIButton) {
      
   }
   
   @IBAction func quantityStepperTapped(_ sender: Any) {
      
   }
   
   
   
   
   
   
   
}
