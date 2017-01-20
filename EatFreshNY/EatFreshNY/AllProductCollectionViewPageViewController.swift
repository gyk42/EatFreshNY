//
//  AllProductCollectionViewPageViewController.swift
//  EatFreshNY
//
//  Created by Matt Tripodi on 1/14/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class AllProductCollectionViewPageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
	
    var ref: FIRDatabaseReference!
    var source:String?
    var products = [Product]()
    
	// IBOutlets 
	@IBOutlet weak var allProductsCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        productCollectionDisplay()
        print("---------------------\(source ?? "This is test")----------------------")
    }
    
	
    func productCollectionDisplay() {
        let productsRef = FIRDatabase.database().reference(withPath:"products")
        productsRef.observeSingleEvent(of: .value, with: { (snapshot) in
            for product in snapshot.children {
                let name = Product(snapshot: product as! FIRDataSnapshot)
                self.products.append(name)
            }
            DispatchQueue.main.async {
                self.allProductsCollectionView.reloadData()
            }
        })
    }
   
	// CollectionView 
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return products.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allProductsCell", for: indexPath) as! AllProductsCollectionViewCell
        cell.productNameLabel.text = products[indexPath.row].name
        
        
		return cell 
	}
    
    
}
