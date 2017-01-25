//
//  FavoritesTableViewCell.swift
//  EatFreshNY
//
//  Created by Matt Tripodi on 1/19/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
	
	// MARK: IBOutlets ------------------------------------------
   
	@IBOutlet weak var favoriteImage: UIImageView!
	@IBOutlet weak var favoriteVendorLabel: UILabel!

   // MARK: override ------------------------------------------
   
   override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
