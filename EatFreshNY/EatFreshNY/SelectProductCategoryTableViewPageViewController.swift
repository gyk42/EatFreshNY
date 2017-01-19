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

        // Do any additional setup after loading the view.
    }
	
	
	// TableView
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 6
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
		return cell
	}

	
	// IBActions 
	@IBAction func logOutButtonTapped(_ sender: Any) {
	}


}
