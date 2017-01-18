//
//  SelectVendorTableViewCell.swift
//  EatFreshNY
//
//  Created by Matt Tripodi on 1/14/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit

class SelectVendorTableViewCell: UITableViewCell {
	
	// IBOutlets 
	@IBOutlet weak var vendorImage: UIImageView!
	@IBOutlet weak var vendorNameLabel: UILabel!
	

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}