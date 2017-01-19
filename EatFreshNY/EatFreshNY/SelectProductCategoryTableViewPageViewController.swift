//
//  SelectProductCategoryTableViewPageViewController.swift
//  EatFreshNY
//
//  Created by Matt Tripodi on 1/17/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit

class SelectProductCategoryTableViewPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	// IBOutlets 
	@IBOutlet weak var selectProductCategoryTableView: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

    }
	
	var productCategoryImageArray: [String] = ["baked", "dairy", "fruits", "honey", "fish", "meat"]
	
	// TableView
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 6
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! SelectProductTableViewCell
		cell.ProductCategoryImageOutlet.image = UIImage(named:self.productCategoryImageArray[indexPath.row])
		return cell
	}

	
	// IBActions 
	@IBAction func logOutButtonTapped(_ sender: Any) {
	}


}
