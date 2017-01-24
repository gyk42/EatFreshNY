//
//  CartViewController.swift
//  EatFreshNY
//
//  Created by Matt Tripodi on 1/14/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var cartModel = CartModel()
	var itemClass = [Item]()
	var cartCell = CartTableViewCell()
   var productsImages = [String]()
   var modelImage : ImageP!
	
	// MARK: IBOutlets --------------------------------------------------------------------------------------
	@IBOutlet weak var cartTableView: UITableView!
	@IBOutlet weak var cartNumberOfItemsTotalLabel: UILabel!
	@IBOutlet weak var cartTotalPriceLabel: UILabel!
	
	// MARK: IBActions ----------------------------------------------------------------------------------------
	@IBAction func purchaseButtonTapped(_ sender: Any) {
		
		
		
	}
	
	// MARK: ViewDidLoad ---------------------------------------------------------------------------------------
	override func viewDidLoad() {
		super.viewDidLoad()
      modelImage = ImageP()

      
      itemClass = CartModel.shared.cart
		
		// Displays the total number of items currently in the cart
		cartNumberOfItemsTotalLabel.text = String(itemClass.count)
		
		// Displays the subtotal price in the cartTotalPriceLabel
		let numberOfItems = Int(cartNumberOfItemsTotalLabel.text!)
		
		// Displays the subtotal amount in currency format Ex 35.99
		if let formatedPrice = cartTotalPriceLabel.text {
			
			let formatter = NumberFormatter()
			formatter.numberStyle = .currency
			let totalPrice = Float(formatter.number(from: formatedPrice) ?? 0)
			let calculatedPrice = calculateTotalPrice(qty: numberOfItems!, priceItem: totalPrice)
			cartTotalPriceLabel.text = String(calculatedPrice)
		}
	}
	
	// MARK: ViewWillAppear -------------------------------------------------------------------------------------
	override func viewWillAppear(_ animated: Bool) {
		cartTableView.reloadData()
		
	}
	
	// MARK: Calculate cart total price function ---------------------------------------------------------------
	 func calculateTotalPrice(qty: Int, priceItem: Float) -> Float {
	   var productTotal: Float = 0 
		productTotal = Float(qty) * priceItem
		
		return productTotal
	}
	
	
	// MARK: TableView ------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemClass.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
		
		CartModel.shared.loadPersistedCartFromDefaults()
		cell.data = itemClass[indexPath.row]
      
      let imageName = itemClass[indexPath.row].productPhoto
    
      
      modelImage.downloadImage(named: imageName, complete: { image in
         if let i = image {
            cell.productImage.image = i
         }
      })

      
      
		return cell
	}
	
	// To delete items from the Cart Table View
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			itemClass.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		} else if editingStyle == .insert {
			
		}
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
 
}
