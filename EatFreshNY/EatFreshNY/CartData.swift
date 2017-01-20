//
//  CartData.swift
//  EatFreshNY
//
//  Created by Matt Tripodi on 1/19/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import Foundation

class CartModel {
	static let shared = CartModel()
	init() {}
	let Key = "Persisted-Cart"
	
	func persistCartToDefaults() {
		
		let data = NSKeyedArchiver.archivedData(withRootObject: cartID)
		UserDefaults.standard.set(data, forKey: Key)
	}
	
	func loadPersistedCartFromDefaults() {
		
		if let data = UserDefaults.standard.object(forKey: Key) as? Data {
			let unarch = NSKeyedUnarchiver.unarchiveObject(with: data)	as! [CartID]
			cartID = unarch
		}
	}
	
	var cartID = [CartID]()
	var availableCart: CartID?
	
	class CartID: NSObject, NSCoding {
		
		private struct Keys {
			
			static let productName = "product name"
			static let productPrice = "product price"
			static let productQuantity = "product quantity"
		}
		
		var productName: String
		var productPrice: Float
		var productQuantity: Int
		
		init(productName: String, productPrice: Float, productQuantity: Int) {
			self.productName = productName
			self.productPrice = productPrice
			self.productQuantity = productQuantity
		}
		
		required init?(coder aDecoder: NSCoder) {
			productName = aDecoder.decodeObject(forKey: Keys.productName) as! String
			productPrice = aDecoder.decodeObject(forKey: Keys.productPrice) as! Float
			productQuantity = aDecoder.decodeObject(forKey: Keys.productQuantity) as! Int
		}
		
		func encode(with aCoder: NSCoder) {
			aCoder.encode(productName, forKey: Keys.productName)
			aCoder.encode(productPrice, forKey: Keys.productPrice)
			aCoder.encode(productQuantity, forKey: Keys.productQuantity)
		}
	}
}
