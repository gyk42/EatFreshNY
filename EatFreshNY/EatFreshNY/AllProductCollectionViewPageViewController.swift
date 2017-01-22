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
   static var categoryName: String?
   var products = [Product]()
   var modelImage = ImageP()
   
   
   // IBOutlets
   @IBOutlet weak var allProductsCollectionView: UICollectionView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      productCollectionDisplay()
   }
   
   func productCollectionDisplay() {
      let productsRef = FIRDatabase.database().reference(withPath:"products")
      let productID = productsRef.ref.key
      let productsQuery = productsRef.queryOrdered(byChild: "category").queryEqual(toValue: AllProductCollectionViewPageViewController.categoryName)
      
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
      
//MARK : STEPS TO GET IMAGE  from storage  
   /// to call this u need in each ViewContraller to call: copy/paste
    //  import FirebaseStorage
   //var modelImage = ImageP()
   // func getImageFromStorage()

      // get the name of the image
       let productImage = products[indexPath.row].imageOne
      // call funcion and give it name
      cell.productImage.image = getImageFromStorage(imageName: productImage)
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
   
   // this func gets the image data from a fucnfion in Image Procecing model and return a UIImage
   func getImageFromStorage(imageName: String)-> UIImage {
      var newImage = UIImage()
      modelImage.downloadImage(named: imageName, complete: { image in
         
         if let i = image {
            newImage = i
         }
      })
     return newImage
   }
 
   
   
}//End ViewController

