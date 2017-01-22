//
//  InventoryProductViewController.swift
//  EatFreshNY
//
//  Created by Richel Cuyler on 1/22/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit
import Firebase

class InventoryProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    var ref: FIRDatabaseReference!
    static var userID = FIRAuth.auth()!.currentUser!.uid
    var products = [Product]()
    
    @IBOutlet weak var InventoryProductTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productTableviewDisplay()
        // Do any additional setup after loading the view.
    }
    func productTableviewDisplay() {
        let productsRef = FIRDatabase.database().reference(withPath:"products")
        let productID = productsRef.ref.key
        let productsQuery = productsRef.queryOrdered(byChild: "userID").queryEqual(toValue: InventoryProductViewController.userID)
        
        productsQuery.observeSingleEvent(of: .value, with: { (snapshot) in
            
            for product in snapshot.children {
                
                let product = Product(snapshot: product as! FIRDataSnapshot)
                self.products.append(product)
                print(product)
            }
            DispatchQueue.main.async {
                self.InventoryProductTableView.reloadData()
            }
        })
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inventoryCell", for: indexPath) as! InventoryProductTableViewCell
        //        var imageName = ""
        //        imageName = NSUUID().uuidString
        cell.productName.text = products[indexPath.row].name
        cell.productPrice.text = products[indexPath.row].price
        cell.productQuantity.text = products[indexPath.row].quantity
        cell.productDescription.text = products[indexPath.row].description
        cell.productMarketDate.text = products[indexPath.row].marketDate
        //cell.productImage.image = products[indexPath.row].image
        
        return cell
    }

 

}
