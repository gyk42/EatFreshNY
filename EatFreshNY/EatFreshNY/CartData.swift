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
	var Key = "cartKey"
	
	var cart = [Item]()
	var availableCartItem: Item?
	func persistCartToDefaults() {
		
		let data = NSKeyedArchiver.archivedData(withRootObject: cart)
		UserDefaults.standard.set(data, forKey: Key)
	}
	
	func loadPersistedCartFromDefaults() {  //get info from memorey
		
		if let data = UserDefaults.standard.object(forKey: Key) as? Data {
			let unarch = NSKeyedUnarchiver.unarchiveObject(with: data)	as! [Item]
			cart = unarch
		}
	}
}
	
	class Item: NSObject, NSCoding {
		
		struct Keys {
			//static let productId = "productID"
			static let productName = " productName"
			static let productPrice = "productPrice"
			static let productQuantity = "productQuantity"
			static let productPhoto = "productPhoto"
			
		}
		
		//var productId : String?
		var productName: String
		var productPrice: Float
		var productQuantity: Int
		var productPhoto: String
		
		init(productName: String, productPrice: Float, productQuantity: Int, /*productId : String?,*/
		     productPhoto: String) {
			self.productName = productName
			self.productPrice = productPrice
			self.productQuantity = productQuantity
			//self.productId	 = productId
			self.productPhoto = productPhoto
		}
		
		required init?(coder aDecoder: NSCoder) {
			productName = aDecoder.decodeObject(forKey: Keys.productName) as! String
			productPrice = aDecoder.decodeObject(forKey: Keys.productPrice) as! Float
			productQuantity = aDecoder.decodeObject(forKey: Keys.productQuantity) as! Int
			//productId = aDecoder.decodeObject(forKey: Keys.productId) as! String?
			productPhoto = aDecoder.decodeObject(forKey: Keys.productPhoto) as! String
			
		}
		
		func encode(with aCoder: NSCoder) {
			aCoder.encode(productName, forKey: Keys.productName)
			aCoder.encode(productPrice, forKey: Keys.productPrice)
			aCoder.encode(productQuantity, forKey: Keys.productQuantity)
			//aCoder.encode(productId, forKey: Keys.productId)
			aCoder.encode(productPhoto, forKey: Keys.productPhoto)
		}
	}
//END of Class
