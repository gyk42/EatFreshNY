//
//  ProductDetailPageViewController.swift
//  EatFreshNY
//
//  Created by Matt Tripodi on 1/14/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit

class ProductDetailPageViewController: UIViewController {
	
	// IBOutlets
	@IBOutlet weak var productDetailImage: UIImageView!
	@IBOutlet weak var productNameLabel: UILabel!
	@IBOutlet weak var productDescriptionLabel: UILabel!
	@IBOutlet weak var productPriceLabel: UILabel!
	@IBOutlet weak var quantityNumberLabel: UILabel!
	
	// IBActions
	@IBAction func addToCartButtonTapped(_ sender: UIButton) {
	}
	@IBAction func quantityStepperTapped(_ sender: Any) {
	}
	
	

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
