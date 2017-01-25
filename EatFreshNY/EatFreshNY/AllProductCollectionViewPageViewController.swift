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
import FirebaseStorage

class AllProductCollectionViewPageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
   var products = [Product]()
   var ref: FIRDatabaseReference!
   var modelImage : ImageP!
   static var selectedProductValue: String?
   static var selectedProductKey : String?
   
   // MARK: IBOutlets ----------------------------------------------------
   
   @IBOutlet weak var allProductsCollectionView: UICollectionView!
   
   // MARK: override ----------------------------------------------------
   
   override func viewDidLoad() {
      super.viewDidLoad()
      modelImage = ImageP()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      productCollectionDisplay()
   }
   
   // MARK: Funcitons ----------------------------------------------------
   
   func productCollectionDisplay() {
      let productsRef = FIRDatabase.database().reference(withPath:"products")
      let productsQuery = productsRef.queryOrdered(byChild: AllProductCollectionViewPageViewController.selectedProductKey!).queryEqual(toValue: AllProductCollectionViewPageViewController.selectedProductValue)
      
      productsQuery.observeSingleEvent(of: .value, with: { (snapshot) in
         
         for product in snapshot.children {
            let product = Product(snapshot: product as! FIRDataSnapshot)
            self.products.append(product)
         }
         
         DispatchQueue.main.async {
            self.allProductsCollectionView.reloadData()
         }
      })
   }
   
   // MARK: CollectionView ----------------------------------------------
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return products.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allProductsCell", for: indexPath) as! AllProductsCollectionViewCell
      
      cell.productNameLabel.text = products[indexPath.row].name
      print(products[indexPath.row].name)
      
      let imageName = products[indexPath.row].imageOne
      print (imageName)
      
      modelImage.downloadImage(named: imageName, complete: { image in
         if let i = image {
            cell.productImage.image = i
         }
      })
      
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      self.performSegue(withIdentifier: "ToDetail", sender: products[indexPath.row])
   }
   
   // MARK: override ----------------------------------------------
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "ToDetail" {
         let destination = segue.destination as! ProductDetailPageViewController
         destination.product = products[(allProductsCollectionView.indexPathsForSelectedItems!.first!.item)]
      }
   }
}
