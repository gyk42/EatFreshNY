//
//  SelectVendorTableViewPageViewController.swift
//  EatFreshNY
//
//  Created by Matt Tripodi on 1/14/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage



class SelectVendorTableViewPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
   
   var ref: FIRDatabaseReference!
   static var selecrtedProductValue: String?
   static var selectedProductKey : String?
   var vendorsList = [User]()
   var modelImage : ImageP!
   
   
   
   
   // IBOutlets
   @IBOutlet weak var selectVendorTableView: UITableView!
   
   // //MARK: viewDidLoad
   override func viewDidLoad() {
      super.viewDidLoad()
      modelImage = ImageP()
      
      
      
      
      
   }// END ViewDidLoad
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      vendorsDisplay()
   }
   
   
   
   
   // TableView
   
   //  @IBOutlet weak var vendorImage: UIImageView!
   //  @IBOutlet weak var vendorNameLabel: UILabel!
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return vendorsList.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "vendorCell", for: indexPath)
         as! SelectVendorTableViewCell
      
      
      cell.vendorNameLabel.text = vendorsList[indexPath.row].userName
      print(vendorsList[indexPath.row].userName)
      //
      let imageName = products[indexPath.row].imageOne
      print (imageName)
      //       call funcion and give it name
      modelImage.downloadImage(named: imageName, complete: { image in
         if let i = image {
            cell.vendorImage.image = i
         }
      })
      
      
      return cell
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      self.performSegue(withIdentifier: "vendorsToproducts", sender: vendorsList[indexPath.row].userID)
   }
   
   
   
   
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "vendorsToproducts" {
         let destination = segue.destination as! SelectVendorTableViewPageViewController
         SelectVendorTableViewPageViewController.selecrtedProductValue = sender as? String
         SelectVendorTableViewPageViewController.selectedProductKey = "userID"
         //
         
      }
   }//END prepare sagues
   
   
   
   
   override func didReceiveMemoryWarning() {
      
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   func vendorsDisplay() {
      
      let usersRef = FIRDatabase.database().reference(withPath:"users")
      
      let vendorsQuery = usersRef.queryOrdered(byChild: "userRole").queryEqual(toValue: SelectVendorTableViewPageViewController.self)
      
      vendorsQuery.observeSingleEvent(of: .value, with: { (snapshot) in
         
         let rolesnapshot = snapshot.childSnapshot(forPath: "userRole").value!
         if rolesnapshot as! String == "vendor"{
            
            self.vendorsList.append(rolesnapshot as! User)
            
            
         }
         DispatchQueue.main.async {
            self.selectVendorTableView.reloadData()
         }
      })
      
   }//END of vendorDisplay
   
   
   
   
   
   
   
   
   
}// END SelectVendorTableViewPageViewController
