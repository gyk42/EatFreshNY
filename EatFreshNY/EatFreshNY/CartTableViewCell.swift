//
//  CartTableViewCell.swift
//  EatFreshNY
//
//  Created by Matt Tripodi on 1/14/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
   
   // MARK: IBOutlets ----------------------------------------------
   
   @IBOutlet weak var productImage: UIImageView!
   @IBOutlet weak var productNameLabel: UILabel!
   @IBOutlet weak var priceAmountLabel: UILabel!
   @IBOutlet weak var quantityAmountLabel: UILabel!
   @IBOutlet weak var stepper: UIStepper!
   
   var data: Item? {
      didSet {
         updateUI()
      }
   }
   
   func updateUI() {
      stepper.wraps = true
      stepper.autorepeat = true
      stepper.maximumValue = 10
      
      productNameLabel.text = data?.productName ?? "unknown"
      priceAmountLabel.text = "\(data?.productPrice))"
      quantityAmountLabel.text = "\(data?.productQuantity))"
   }
   
   
   // MARK: IBActions ---------------------------------------------
   
   @IBAction func quantityStepperTapped(_ sender: UIStepper) {
      quantityAmountLabel.text = Int(sender.value).description
   }
   
   // MARK: override ---------------------------------------------
   
   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      // Configure the view for the selected state
   }
   
}
