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
    //var productID: String
    var name: String
    var marketDate: String
    var image: String
    var description: String
    var price: String
    var quantity: String
    var category: String
    var ref: FIRDatabaseReference?
    
    init(name: String, marketDate: String = "", image: String, description: String, price: String, quantity: String, category: String) {
        self.name = name
        self.marketDate = marketDate
        self.image = image
        self.description = description
        self.price = price
        self.quantity = quantity
        self.category = category
    }
    
    init(snapshot: FIRDataSnapshot) {
        //productID = snapshot.key
        //let snapshotValue = snapshot.value as! [String : AnyObject]
        name = snapshot.childSnapshot(forPath: "name").value as! String
        marketDate = snapshot.childSnapshot(forPath: "market_date").value as! String
        //= Date(timeIntervalSince1970: interval)
        image = snapshot.childSnapshot(forPath: "image").value as! String
        description = snapshot.childSnapshot(forPath: "description").value as! String
        price = snapshot.childSnapshot(forPath: "price").value as! String
        quantity = snapshot.childSnapshot(forPath: "quantity").value as! String
        category = snapshot.childSnapshot(forPath: "category").value as! String
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
