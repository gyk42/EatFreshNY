//
//  ProductDataModel.swift
//  EatFreshNY
//
//  Created by Richel Cuyler on 1/18/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore

var products = [Product]()
var productToEdit: Product!
var ref: FIRDatabaseReference!

//PRODUCT CLASS:
class Product {
   var productID: String?
   var name: String
   var marketDate: String
   var imageOne: String  // now we have 4 image for producsts
   var imageTwo: String
   var imageThree: String
   var imageFour: String
   var description: String
   var price: String
   var quantity: String
   var category: String
   var userID = FIRAuth.auth()?.currentUser?.uid
   var ref: FIRDatabaseReference?
   
   init(name: String, marketDate: String = "", imageOne: String,imageTwo: String,imageThree: String,imageFour: String, description: String, price: String, quantity: String, category: String, userID: String) {
      self.name = name
      self.marketDate = marketDate
      self.imageOne = imageOne
      self.imageTwo = imageTwo
      self.imageThree = imageThree
      self.imageFour = imageFour
      self.description = description
      self.price = price
      self.quantity = quantity
      self.category = category
      self.userID = userID
   }
   
   init(snapshot: FIRDataSnapshot) {
      productID = snapshot.key
      let snapshotValue = snapshot.value as! [String : AnyObject]
      name = snapshotValue["name"] as! String
      marketDate = snapshotValue["market_date"] as! String
      imageOne = snapshotValue["imageOne"] as! String
      imageTwo = snapshotValue["imageTwo"] as! String
      imageThree = snapshotValue["imageThree"] as! String
      imageFour = snapshotValue["imageFour"] as! String
      description = snapshotValue["description"] as! String
      price = snapshotValue["price"] as! String
      quantity = snapshotValue["quantity"] as! String
      category = snapshotValue["category"] as! String
      userID = snapshotValue["userID"] as? String
      ref = snapshot.ref
   }
   
   func toAnyObject() -> [String: Any] {
      return [
         "productID": productID as Any as AnyObject,
         "name": name as String as AnyObject,
         "market_date": marketDate as String as AnyObject,
         "imageOne": imageOne as String as AnyObject,
         "imageTwo": imageTwo as String as AnyObject,
         "imageThree": imageThree as String as AnyObject,
         "imageFour": imageFour as String as AnyObject,
         "description": description as String as AnyObject,
         "price" : price as String as AnyObject,
         "quantity" : quantity as String as AnyObject,
         "category" : category as String as AnyObject,
         "userID" : userID! as String as AnyObject
      ]
   }
}

extension Date {
   func format() -> String {
      return Format.shared.dateFormatter.string(from: self)
   }
}

class Format {
   static let shared = Format()
   let dateFormatter = DateFormatter()
   private init() {
      dateFormatter.dateStyle = .long
      dateFormatter.timeStyle = .long
   }
}

//PRODUCT MODEL:

class ProductModel {
   static let shared = ProductModel()
   private init() {}
   
   // MARK: - FB Read -----------------------------------------------
   func listenForProducts() {
      let products = FIRDatabase.database().reference(withPath: "products")
      products.observe(.value, with: didUpdateProducts)
   }
   
   // MARK: - FB: Create Product, Delete Product, Update Product ------------------------
   func createProduct(name: String, imageOne: String = "",imageTwo: String = "",imageThree: String = "",imageFour: String = "", description: String, price: String, quantity: String, category: String, userID: String) {
      
      let productsRef = FIRDatabase.database().reference(withPath: "products")
      let product = Product(name: name, marketDate: Date().format(), imageOne: imageOne,imageTwo: imageTwo, imageThree: imageThree,imageFour: imageFour, description: description, price: price, quantity: quantity, category: category, userID: userID)
      let productRef = productsRef.childByAutoId()
      productRef.setValue(product.toAnyObject())
   }
   
   func deleteProduct(product: Product) {
      product.ref?.removeValue()
   }
   
   func didUpdateProducts(snapshot: FIRDataSnapshot) {
      products.removeAll()
      for item in snapshot.children {
         let product = Product(snapshot: item as! FIRDataSnapshot)
         products.append(product)
      }
   }
   
   func updateProduct(newName: String? = nil, newDescription: String? = nil, newPrice: String? = nil, newQuantity: String? = nil, product: Product) {
      if productToEdit.name == newName {
         productToEdit.ref?.updateChildValues([
            "description" : newDescription!,
            "price": newPrice!,
            "quantity": newQuantity!,
            ])
      }
   }
}
