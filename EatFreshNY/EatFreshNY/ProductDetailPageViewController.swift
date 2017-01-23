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

// MARK: Extentions ---------------------------------------------------------------------
extension String {
	var floatValue: Float {
		return (self as NSString).floatValue
	}
}

extension String {
	var intValue: Int {
		return Int((self as NSString).intValue)
	}
}

class ProductDetailPageViewController: UIViewController {
  
  var product: Product?
	var cartModelClass = CartModel()

   //ImageProsissing
   var ref: FIRDatabaseReference!
   var modelImage : ImageP!
   // animation 
   var productImagesNames = [String]()
   var poductsImageData = [UIImage] ()
	var itemsInTheCart: Item?

   // MARK: IBOutlets --------------------------------------------------------------------
   @IBOutlet weak var productDetailImage: UIImageView!
   @IBOutlet weak var productNameLabel: UILabel!
   @IBOutlet weak var productDescriptionLabel: UILabel!
   @IBOutlet weak var productPriceLabel: UILabel!
   @IBOutlet weak var quantityNumberLabel: UILabel!
	
	// MARK: ViewDidLoad -------------------------------------------------------------------
   override func viewDidLoad() {
      super.viewDidLoad()
      modelImage = ImageP()
      animationProductImage()
      
      self.productNameLabel.text = product?.name
      self.productDescriptionLabel.text = product?.description
      self.productPriceLabel.text = product?.price
      self.quantityNumberLabel.text = product?.quantity
      //self.productDetailImage.image = product?.image


      
   } // END ViewDidLoad
   
   
   
   
   override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
      
   }

   // MARK: IBActions ------------------------------------------------------------------------
   @IBAction func addToCartButtonTapped(_ sender: UIButton) {
		
		CartModel.shared.Key = NSUUID().uuidString // creates a randome string to  be uses as cartID
		
		//Item(productName: productNameLabel.text!, productPrice: (productPriceLabel.text!.floatValue), productQuantity: (quantityNumberLabel.text!.intValue), productPhoto: productDetailImage.image!)
		
		Item(productName: productNameLabel.text!, productPrice: (productPriceLabel.text!.floatValue), productQuantity: (quantityNumberLabel.text!.intValue), productId: itemsInTheCart?.productId)
		
		

   }
	
   // MARK: IBAction Buttons --------------------------------------------------------------------
   @IBAction func quantityStepperTapped(_ sender: Any) {
      
   }
   
   
   
   
   // Image Animation
   
   func animationProductImage () {
      productImagesNames = [(product?.imageOne)!, (product?.imageTwo)!, (product?.imageThree)!, (product?.imageFour)!]
      
      for imageName in productImagesNames {
         modelImage.downloadImage(named: imageName, complete: { image in
            if let i = image {
               self.poductsImageData.append(i)
               print(self.poductsImageData.count)
               if self.poductsImageData.count == 4 {
                  self.allImagesLoaded()
               }
            }
            
         })
         
      }
      
   }//END fucn animationProductImage
   
   
   func allImagesLoaded() {
      productDetailImage.animationImages = poductsImageData
      productDetailImage.animationDuration = 6.0
      productDetailImage.startAnimating()
   }
   

}// END ProductDetailPageViewController
