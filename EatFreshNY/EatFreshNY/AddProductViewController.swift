//
//  AddProductViewController.swift
//  EatFreshNY
//
//  Created by Richel Cuyler on 1/18/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AddProductViewController: UIViewController {
    
    var products = [Product]()
    
    
    @IBOutlet weak var productName: UITextField!
    
    @IBOutlet weak var productQuantity: UITextField!
    
    @IBOutlet weak var productPrice: UITextField!
    
    @IBOutlet weak var productCategory: UILabel!
    
    @IBOutlet weak var productDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createProduct(name: "Apple", image: "Richel.jpeg", description: "Macintosh", price: "$1/lb", quantity: "4", category: "Fruits")
    }
    
    
    
    @IBAction func productInformationSaved(_ sender: UIButton) {
        
    }
    
    
    func didUpdateProducts(snapshot: FIRDataSnapshot) {
        
        products.removeAll()
        for item in snapshot.children {
            let product = Product(snapshot: item as! FIRDataSnapshot)
            self.products.append(product)
        }
        print(products)
    }
    
    // MARK: - FB Read
    func listenForProducts() {
        
        // queryOrdered(byChild: "completed")
        let products = FIRDatabase.database().reference(withPath: "products")
        products.observe(.value, with: didUpdateProducts)
    }
    
    
    // MARK: - FB: Create Product, Delete Product, Update Product
    func createProduct(name: String, image: String, description: String, price: String, quantity: String, category: String) {
        
        let productsRef = FIRDatabase.database().reference(withPath: "products")
        let product = Product(name: name, marketDate: Date().format(), image: image, description: description, price: price, quantity: quantity, category: category)
        let productRef = productsRef.child(name)
        productRef.setValue(product.toAnyObject())
    }
    
    
    
    func deleteProduct(product: Product) {
        product.ref?.removeValue()
    }
    
    
    //    func updateProduct() {
    //    let key = ref.child("products").childByAutoId().key
    //    let post = ["uid": userID,
    //                "author": username,
    //                "title": title,
    //                "body": body]
    //    let childUpdates = ["/posts/\(key)": post,
    //                        "/user-posts/\(userID)/\(key)/": post]
    //    ref.updateChildValues(childUpdates)
    
    
    
    
    //    func updateProduct(newName: String, newMarketDate: String, newImage: String, newDescription: String, newPrice: String, newQuantity: String, newCategory: String, product: Product) {
    //
    //        if product.name == newName {
    //            note.ref?.updateChildValues([
    //                "content": newContent,
    //                "date": Date().format()
    //                ])
    //        } else {
    //            note.ref?.removeValue()
    //            createNote(title: newTitle, content: newContent)
    //        }
    //    }
    
    
}

