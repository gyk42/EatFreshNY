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

class VendorSettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
   var ref: FIRDatabaseReference!
   var model: ImageP! //
   
   // MARK: IBOutlets ----------------------------------------
   
   @IBOutlet weak var vendorName: UITextField!
   @IBOutlet weak var vendorDescriptionTextView: UITextView!
   @IBOutlet weak var vendorContactEmail: UITextField!
   @IBOutlet weak var vendorPhoneNumber: UITextField!
   @IBOutlet weak var addressTextfield: UITextField!
   @IBOutlet weak var vendorWebsite: UITextField!
   @IBOutlet weak var photoImageView: UIImageView!
   @IBAction func addLogoButton(_ sender: UIButton) {
      pickImagePressed()
   }
   
   // MARK: @IBAction ------------------------------------
   
   @IBAction func logoutButton(_ sender: Any) {
      UserModel.shared.logout()
   }
   
   // SAVE Button
   @IBAction func saveButtonTapped(_ sender: Any){
      if let email = vendorContactEmail.text,
         let location = addressTextfield.text,
         let name = vendorName.text,
         let phone = vendorPhoneNumber.text,
         let website = vendorWebsite.text {
         let description = vendorDescriptionTextView.text/// this  elementis  missing in user/firebase (osakar)
         let currentUserID = FIRAuth.auth()!.currentUser!.uid
         self.ref.child("users").updateChildValues(["\(currentUserID)":["userRole": "vendor", "userEmail": email, "userLocation" : location, "userName" : name, "userPhoneNumber": phone, "userWebsite": website, "userLogo" : imageName]])
         
         UserModel.shared.user?.userEmail = email
         UserModel.shared.user?.userLocation = location
         UserModel.shared.user?.userName = name
         UserModel.shared.user?.userPhoneNumber = phone
         UserModel.shared.user?.userWebsite = website
         UserModel.shared.user?.userLogo = imageName
         
         populateUser()
      }
   }
   
   // MARK: override -----------------------------------------
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Image picker
      model = ImageP()
      imagePickerController.delegate = self
      ref = FIRDatabase.database().reference()
      populateUser()
      // it calls Image
      downloadImage(imageName: imageName)
   }
   
   func populateUser() {
      vendorContactEmail.text = UserModel.shared.user?.userEmail
      addressTextfield.text = UserModel.shared.user?.userLocation
      vendorName.text = UserModel.shared.user?.userName
      vendorPhoneNumber.text = UserModel.shared.user?.userPhoneNumber
      vendorWebsite.text = UserModel.shared.user?.userWebsite
   }
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
   }
   
   //PHOTO FIREBASE
   // SAVE image TO  FireBas
   func uploadImage(image: UIImage, imageName: String ) {
      model.uploadImage(withData: UIImagePNGRepresentation(image)!, named: imageName)
   }
   
   // GEt image from Firebase
   func downloadImage(imageName: String)  {
      model.downloadImage(named: imageName, complete: { image in
         if let i = image {
            self.photoImageView.image = i
         }
      })
   }
   
   //IMAGE PICKER funcs
   let imagePickerController = UIImagePickerController()
   var logoPhoto = " "
   var imageName = ""
   
   func pickImagePressed (){
      let imagePickerController = UIImagePickerController()
      imagePickerController.delegate = self
      
      let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
      
      actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
         if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
         } else {
            print("Camera not available")
         }
      }))
      
      actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action: UIAlertAction) in
         imagePickerController.sourceType = .photoLibrary
         self.present(imagePickerController, animated: true, completion: nil)
      }))
      
      actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
      
      self.present(actionSheet, animated: true, completion: nil)
   }
   
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
      let image = info[UIImagePickerControllerOriginalImage] as! UIImage
      imageName = NSUUID().uuidString // creates a randome string to  be uses as photo name
      photoImageView.image = image
      picker.dismiss(animated: true, completion: nil)
   }
   
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      picker.dismiss(animated: true, completion: nil)
   }
}
