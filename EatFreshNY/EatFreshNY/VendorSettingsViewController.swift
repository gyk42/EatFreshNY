//
//  VendorSettingsViewController.swift
//  EatFreshNY
//
//  Created by Yoon Yu on 1/19/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import Foundation
import Firebase
import FirebaseDatabase

class VendorSettingsViewController: UIViewController {
	
	var ref: FIRDatabaseReference!
	
	
	// MARK: IBOutlets ---------------------------------------------------------
	@IBOutlet weak var vendorName: UITextField!
	@IBOutlet weak var vendorDescriptionTextView: UITextView!
	@IBOutlet weak var vendorContactEmail: UITextField!
	@IBOutlet weak var vendorPhoneNumber: UITextField!
	@IBOutlet weak var addressTextfield: UITextField!
	@IBOutlet weak var vendorWebsite: UITextField!
	//MARK: PHOTO INPUT
	@IBOutlet weak var photoImageView: UIImageView!
	@IBAction func addLogoButton(_ sender: UIButton) {
	}
	
	
	
	// MARK: LOGOUT Button ----------------------------------------------------------
	
	@IBAction func logoutButton(_ sender: Any) {
		
		UserModel.shared.logout()
	}
	
	// MARK: SAVE Button-----------------------------------------------------------------------------
	@IBAction func saveButtonTapped(_ sender: Any){
		let email = ""
		let location = ""
		let name = ""
		let phone = ""
		let website = ""
		let currentUserID = FIRAuth.auth()!.currentUser!.uid
		self.ref.child("users").updateChildValues(["\(currentUserID)":["userRole": "vendor", "userEmail": email, "userLocation" : location, "userName" : name, "userPhoneNumber": phone, "userWebsite": website, "userLogo" : "0"]])
		vendorContactEmail.text = email
		addressTextfield.text = location
		vendorName.text = name
		vendorPhoneNumber.text = phone
		vendorWebsite.text = website
		
//			self.ref.child("users").queryOrderedByKey().observeEventType(.Value, { (["\(currentUserID)":["userRole": "vendor", "userEmail": email, "userLocation" : location, "userName" : name, "userPhoneNumber": phone, "userWebsite": website, "userLogo" : "0"]])})
		
	}
	
	// MARK: ViewDidLoad ------------------------------------------------------
	override func viewDidLoad() {
		super.viewDidLoad()
		
		ref = FIRDatabase.database().reference()
	
		vendorContactEmail.text = UserModel.shared.user?.userEmail
		addressTextfield.text = UserModel.shared.user?.userLocation
		vendorName.text = UserModel.shared.user?.userName
		vendorPhoneNumber.text = UserModel.shared.user?.userPhoneNumber
		vendorWebsite.text = UserModel.shared.user?.userWebsite
	}
	
	
}// End Class VendorSettings View Controller
