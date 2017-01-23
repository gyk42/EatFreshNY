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
	
		cartNumberOfItemsTotalLabel.text = String(itemClass.count)
	}
	
	var total: Float = 0
	var productTotal: Float = 0
	
	func calculateTotalPrice() {
		productTotal = 0
		for item in itemClass {
			productTotal += (item.productPrice)
		}
		//total
	}
	
	// MARK: TableView ------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemClass.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
		
		CartModel.shared.loadPersistedCartFromDefaults()
		
		let indexPath = itemClass[indexPath.row]
		cell.productNameLabel.text = indexPath.productName
		cell.priceAmountLabel.text = String(indexPath.productPrice)
		cell.quantityAmountLabel.text = String(indexPath.productQuantity)
		//cell.productImage.image = indexPath.productPhoto
		
		return cell
	}
	
 
}
