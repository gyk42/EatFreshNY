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
   var categoryName: String?
   var products = [Product]()
   
   // IBOutlets
   @IBOutlet weak var allProductsCollectionView: UICollectionView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      productCollectionDisplay()
   }
   
   func productCollectionDisplay() {
      let productsRef = FIRDatabase.database().reference(withPath:"products")
      let productID = productsRef.ref.key
      print("productID: \(productID)")
//      let productsQuery = productsRef.queryOrdered(byChild: "category").queryEqual(toValue: categoryName)
      let productsQuery = productsRef.queryOrdered(byChild: "category").queryEqual(toValue: categoryName)
      
      productsQuery.observeSingleEvent(of: .value, with: { (snapshot) in
         
         for product in snapshot.children {
  //             print("product Ref \(productID)")
            let product = Product(snapshot: product as! FIRDataSnapshot)
            
            self.products.append(product)
            print(product)
            
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
      
      print(products[indexPath.row].category)
      
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     self.performSegue(withIdentifier: "ToDetail", sender: products[indexPath.row])
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "ToDetail" {
         let destination = segue.destination as! ProductDetailPageViewController
         destination.productID = sender as? String
         
      }
   }
   
   
}
