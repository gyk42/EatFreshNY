//
//  CartTableViewCell.swift
//  EatFreshNY
//
//  Created by Matt Tripodi on 1/14/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
	
	// IBOutlets 
	@IBOutlet weak var productImage: UIImageView!
	@IBOutlet weak var productNameLabel: UILabel!
	@IBOutlet weak var priceAmountLabel: UILabel!
	@IBOutlet weak var quantityAmountLabel: UILabel!
	
	// IBActions 
	@IBAction func quantityStepperTapped(_ sender: Any) {
	}
	
	
	
	

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
