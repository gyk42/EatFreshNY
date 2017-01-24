//
//  InventoryProductTableViewCell.swift
//  EatFreshNY
//
//  Created by Richel Cuyler on 1/22/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit
import Firebase

class InventoryProductTableViewCell: UITableViewCell {
    
    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productMarketDate: UILabel!
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productDescription: UITextField!
    @IBOutlet weak var productQuantity: UITextField!
    @IBOutlet weak var productPrice: UITextField!
    
    
    
    //MARK: Update Product Values BUTTON
    
    @IBAction func updateProductValues(_ sender: UIButton) {
        if let name = productName.text,
            let description = productDescription.text,
            let quantity = productQuantity.text,
            let price = productPrice.text {
            let currentUserID = FIRAuth.auth()!.currentUser!.uid
            self.ref.updateChildValues(["name" : name, "description" : description, "quantity" : quantity, "price" : price, "userID" : currentUserID])
        }
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
