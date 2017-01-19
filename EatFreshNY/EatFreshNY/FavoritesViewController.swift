//
//  FavoritesViewController.swift
//  EatFreshNY
//
//  Created by Matt Tripodi on 1/19/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	// MARK: IBOutlets ---------------------------------------------------------------------
	@IBOutlet weak var favoritesTableView: UITableView!
	

    override func viewDidLoad() {
        super.viewDidLoad()

    }

   // MARK: TableView 
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath)
		return cell 
	}
	

}
