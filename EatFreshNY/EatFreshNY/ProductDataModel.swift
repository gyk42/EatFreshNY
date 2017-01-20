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


var products = [Product]()  // needed?

var productToEdit: Product!

var ref: FIRDatabaseReference! // needed?


//PRODUCT CLASS:


class Product {
    
    var productID: String?
    var name: String
    var marketDate: String
    var image: String
    var description: String
    var price: String
    var quantity: String
    var category: String
    var userID = FIRAuth.auth()?.currentUser?.uid
    var ref: FIRDatabaseReference?
    
    init(name: String, marketDate: String = "", image: String, description: String, price: String, quantity: String, category: String, userID: String) {
        self.name = name
        self.marketDate = marketDate
        self.image = image
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
        image = snapshotValue["image"] as! String
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
            "image": image as String as AnyObject,
            "description": description as String as AnyObject,
            "price" : price as String as AnyObject,
            "quantity" : quantity as String as AnyObject,
            "category" : category as String as AnyObject
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
    
    
    // MARK: - FB Read
    func listenForProducts() {
        // queryOrdered(byChild: "completed")
        let products = FIRDatabase.database().reference(withPath: "products")
        products.observe(.value, with: didUpdateProducts)
    }
    
    
    // MARK: - FB: Create Product, Delete Product, Update Product
    func createProduct(name: String, image: String = "", description: String, price: String, quantity: String, category: String, userID: String) {
        
        let productsRef = FIRDatabase.database().reference(withPath: "products")
        let product = Product(name: name, marketDate: Date().format(), image: image, description: description, price: price, quantity: quantity, category: category, userID: userID)
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
        print(products)
    }
    
    
    //func updateProduct() {
        // TODO guard against input values if ok
        // TODO: update productToEdit   - e.g. productToEdit.name = validName
    // let newDictionary = productToEdit.toAnyObject()
    // let firversion = productToEdit.ref
        //firversion?.setValue(newDictionary)
    //}

    
//    func updatePrduct(newName: String? = nil, newDescription: String, newPrice: String, newQuantity: String, newCategory: String, product: Product) {
//            
//            if product.name == newName {
//                productToEdit.ref?.updateChildValues([
//                    "content": newContent,
//                    "date": Date().format()
//                    ])
//            } else {
                //product.name ==
//        }//
}


