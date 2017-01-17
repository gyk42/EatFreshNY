//
//  SelectProductCategoryTableViewPageViewController.swift
//  EatFreshNY
//
//  Created by Group 3 (Grace, Israel, Richel, Matt, Oskar) on 1/6/17.
//  Copyright © 2017 Group 3 (Grace, Israel, Richel, Matt, Oskar) All rights reserved.
//


import UIKit

class SelectProductCategoryTableViewPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	// IBOutlets 
	@IBOutlet weak var selectProductCategoryTableView: UITableView!

   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
   }
	
	
	// TableView 
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 6
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
		return cell 
	}

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }


}

