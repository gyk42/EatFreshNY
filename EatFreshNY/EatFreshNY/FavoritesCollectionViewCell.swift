//
//  FavoritesCollectionViewCell.swift
//  EatFreshNY
//
//  Created by Matt Tripodi on 1/19/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {
	
	// MARK: IBOutlets ------------------------------------------------------
	@IBOutlet weak var vendorImage: UIImageView!
	@IBOutlet weak var vendorNameLabel: UILabel!
	
	// MARK: IBActions ------------------------------------------------------
	@IBAction func heartFavoriteButtonTapped(_ sender: Any) {
		// Hit this button to unfavorite a vendor that you already have as a favorite 
	}
	
    
}
