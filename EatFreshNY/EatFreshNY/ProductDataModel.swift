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


class Product {
    var productID: String
    var name: String
    var marketDate: String
    var image: String
    var description: String
    var price: String
    var quantity: String
    var category: String
    var ref: FIRDatabaseReference?
    
    init(productID: String, name: String, marketDate: String = "", image: String, description: String, price: String, quantity: String, category: String) {
        self.productID = productID
        self.name = name
        self.marketDate = marketDate
        self.image = image
        self.description = description
        self.price = price
        self.quantity = quantity
        self.category = category
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
        ref = snapshot.ref
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "name": name,
            "market_date": marketDate,
            "image": image,
            "description": description,
            "price" : price,
            "quantity" : quantity,
            "category" : category
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
