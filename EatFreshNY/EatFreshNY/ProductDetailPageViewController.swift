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
  
  var product: Product?
	var cartModelClass = CartModel()
	var availableCart: Item?

	
   
   // MARK: IBOutlets --------------------------------------------------------------------
   @IBOutlet weak var productDetailImage: UIImageView!
   @IBOutlet weak var productNameLabel: UILabel!
   @IBOutlet weak var productDescriptionLabel: UILabel!
   @IBOutlet weak var productPriceLabel: UILabel!
   @IBOutlet weak var quantityNumberLabel: UILabel!
	
	// MARK: ViewDidLoad -------------------------------------------------------------------
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.productNameLabel.text = product?.name
      self.productDescriptionLabel.text = product?.description
      self.productPriceLabel.text = product?.price
      self.quantityNumberLabel.text = product?.quantity
      //self.productDetailImage.image = product?.image
		
   }
   
   
   // MARK: IBActions ------------------------------------------------------------------------
   @IBAction func addToCartButtonTapped(_ sender: UIButton) {
		
//		CartModel.shared.Key = NSUUID().uuidString // creates a randome string to  be uses as cartID
//		
//		Item(productName: productNameLabel.text!, productPrice: (productPriceLabel.text!), productQuantity: String(quantityNumberLabel.text!), productPhoto: productDetailImage.image!)
//		
//		Item(
//		(productName: productNameLabel.text!,
//		               productPrice: productPriceLabel.text!,
//		               productQuantity: quantityNumberLabel.text!,
//		               productPhoto: productDetailImage.image!)
		
	
      
   }
	
	
   // MARK: IBAction Buttons --------------------------------------------------------------------
   @IBAction func quantityStepperTapped(_ sender: Any) {
      
   }

}
