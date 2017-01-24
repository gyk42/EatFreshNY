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
   static var selectedProductValue: String?
   static var selectedProductKey : String?
   var vendorsList = [User]()
   var modelImage : ImageP!

   // IBOutlets ------------------------------------------------------------------------
   
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
   
   //  @IBOutlet weak var vendorImage: UIImageView!
   //  @IBOutlet weak var vendorNameLabel: UILabel!
   
   
   // MARK: Tableview ------------------------------------------------------------------------
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return vendorsList.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "vendorCell", for: indexPath)
         as! SelectVendorTableViewCell
      
      cell.vendorNameLabel.text = vendorsList[indexPath.row].userName
      print(vendorsList[indexPath.row].userName)
      
      return cell
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      self.performSegue(withIdentifier: "vendorsToproducts", sender: vendorsList[indexPath.row].userID)
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "vendorsToproducts" {
         if let _ = segue.destination as? SelectVendorTableViewPageViewController {
         SelectVendorTableViewPageViewController.selectedProductValue = sender as? String
         SelectVendorTableViewPageViewController.selectedProductKey = "userID"
         }
         //
         
      }
   }//END prepare sagues
   
   func vendorsDisplay() {
      let usersRef = FIRDatabase.database().reference(withPath:"users")
      
      usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
         if snapshot.hasChildren(){
            
            for userSnapshot in snapshot.children {
               if let firUserSnapshot = userSnapshot as? FIRDataSnapshot {
                  let rolesSnapshot = firUserSnapshot.childSnapshot(forPath: "userRole").value!
                  
                  if rolesSnapshot as! String == "vendor"{
                     let user = User(snapshot: firUserSnapshot)
                     self.vendorsList.append(user)
                  }
               }
            }
            
            DispatchQueue.main.async {
               self.selectVendorTableView.reloadData()
            }
         }
         
      })
   }//END of vendorDisplay
   
   /*
    func vendorsDisplay() {
   
    let usersRef = FIRDatabase.database().reference(withPath:"users")
    
    let vendorsQuery = usersRef.queryOrdered(byChild: "userRole").queryEqual(toValue: SelectVendorTableViewPageViewController.self)
    
    vendorsQuery.observeSingleEvent(of: .value, with: { (snapshot) in
    
    let rolesnapshot = snapshot.childSnapshot(forPath: "userRole").value!
    if rolesnapshot as! String == "vendor"{
    
    self.vendorsList.append(rolesnapshot as! User)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "vendorsToproducts" {
            if let _ = segue.destination as? SelectVendorTableViewPageViewController {
                SelectVendorTableViewPageViewController.selectedProductValue = sender as? String
                SelectVendorTableViewPageViewController.selectedProductKey = "userID"
            }
            //
            
        }
    }//END prepare sagues
    
    func vendorsDisplay() {
        let usersRef = FIRDatabase.database().reference(withPath:"users")
        
        usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChildren(){
                
                for userSnapshot in snapshot.children {
                    if let firUserSnapshot = userSnapshot as? FIRDataSnapshot {
                        let rolesSnapshot = firUserSnapshot.childSnapshot(forPath: "userRole").value!
                        
                        if rolesSnapshot as! String == "vendor"{
                            let user = User(snapshot: firUserSnapshot)
                            self.vendorsList.append(user)
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    self.selectVendorTableView.reloadData()
                }
            }
            
        })
    }//END of vendorDisplay
   
    }
    DispatchQueue.main.async {
    self.selectVendorTableView.reloadData()
    }
    })
    
    }//END of vendorDisplay
    */

}// END SelectVendorTableViewPageViewController
