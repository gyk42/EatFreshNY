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


   
   var ref: FIRDatabaseReference!
   static var selectedProductValue: String?
   static var selectedProductKey : String?
   var products = [Product]()
   var modelImage : ImageP!
   
   // IBOutlets
   @IBOutlet weak var allProductsCollectionView: UICollectionView!
   
   override func viewDidLoad() {
      
      super.viewDidLoad()
       modelImage = ImageP()
      
   }
   
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      productCollectionDisplay()
   }
   
   func productCollectionDisplay() {
      
      let productsRef = FIRDatabase.database().reference(withPath:"products")
      let productsQuery = productsRef.queryOrdered(byChild: AllProductCollectionViewPageViewController.selectedProductKey!).queryEqual(toValue: AllProductCollectionViewPageViewController.selectedProductValue)
      
      productsQuery.observeSingleEvent(of: .value, with: { (snapshot) in
         
         for product in snapshot.children {

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
      print(products[indexPath.row].name)
//MARK : STEPS TO GET IMAGE  from storage  
   /// to call this u need in each ViewContraller to call: copy/paste
    //  import FirebaseStorage
   //var modelImage = ImageP()
   // func getImageFromStorage()

//       get the name of the image
      let imageName = products[indexPath.row].imageOne
      print (imageName)
//       call funcion and give it name
      modelImage.downloadImage(named: imageName, complete: { image in
         if let i = image {
            cell.productImage.image = i
         }
      })
      
      ///////////
      
      
      
      ///////////
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      self.performSegue(withIdentifier: "ToDetail", sender: products[indexPath.row])
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "ToDetail" {
         let destination = segue.destination as! ProductDetailPageViewController
         destination.product = products[(allProductsCollectionView.indexPathsForSelectedItems!.first!.item)]
      }
   }
   
   
   
   
}//End ViewController

