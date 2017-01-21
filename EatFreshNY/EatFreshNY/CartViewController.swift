//
//  CartViewController.swift
//  EatFreshNY
//
//  Created by Matt Tripodi on 1/14/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
   // MARK: IBOutlets --------------------------------------------------------------------------------------
   @IBOutlet weak var cartTableView: UITableView!
   @IBOutlet weak var cartNumberOfItemsTotalLabel: UILabel!
   @IBOutlet weak var cartTotalPriceLabel: UILabel!
   
   // MARK: IBActions ----------------------------------------------------------------------------------------
   @IBAction func purchaseButtonTapped(_ sender: Any) {
   }
	
	// MARK: ViewDidLoad ---------------------------------------------------------------------------------------
   override func viewDidLoad() {
      super.viewDidLoad()
		
		
   }
   
   // MARK: TableView ------------------------------------------------------------------------------------------
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath)
      return cell
   }
   
 
}
