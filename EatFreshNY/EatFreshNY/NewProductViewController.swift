//
//  NewProductViewController.swift
//  EatFreshNY
//
//  Created by oskar morett on 1/18/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit

class NewProductViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
   
   
   var model: ImageP!
///////// Photos ///////////
// MAIN PHOTO
 
   @IBAction func mainPhotoButton(_ sender: UIButton) {
   }
   
// from left to rigth  button and outlets
 
   @IBAction func addPhotoOneButton(_ sender: UIButton) {
   }
   
  
   
   @IBAction func addPhotoTwoButton(_ sender: UIButton) {
   }
   
   
   @IBAction func addPhotoThreeButton(_ sender: UIButton) {
   }
   
   
//// Outlets /////////
   
   @IBOutlet weak var productNameTextfield: UITextField!
   @IBOutlet weak var productDescriptionTextfield: UITextView!
   @IBOutlet weak var qtyTextfield: UITextField!
   
   
   @IBOutlet weak var addPhotoOneImage: UIImageView!
   @IBOutlet weak var addPhotoTwoImage: UIImageView!
   @IBOutlet weak var addPhotoThreeImage: UIImageView!
   
   
 //// Buttons/////
   
   @IBAction func saveNewProductButtton(_ sender: UIButton) {
   }
   
   
   
   
   // >>>>>>>>>>>>>>>>>>>>>>Image to FireBAse >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
   // SAVE image TO  FireBas
   func uploadImage(image: UIImage ) {
      
         model.uploadImage(withData: UIImagePNGRepresentation(image)!, named: "\(photoName)")
      
   }
   
   
   
   // GEt image from Firebase
   
   func downloadImage() {
      
      model.downloadImage(named: "niM7azZS.png", complete: { image in
         
         if let i = image {
           // self.getImage.image = i
         }
      })
      
   }
   
   
   //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ImagePicker  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   
   // let picker  =  ImagePicker()
   
   let imagePickerController = UIImagePickerController()
   var photoName = " "
//   var onePhotoName = " "
//   var twoPhotoName = " "
//   var threePhotoName = " "
//   
   @IBAction func pickImageButton(_ sender: UIButton) { // not conected
      
      pickImagePressed()
      
   }
   
   
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
   //
   
   
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
   let image = info[UIImagePickerControllerOriginalImage] as! UIImage
      let imageName = NSUUID().uuidString
      
            
      
      picker.dismiss(animated: true, completion: nil)
   }
   //

   
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      picker.dismiss(animated: true, completion: nil)
   }
   //
   ////<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   
   
   override func viewDidLoad() {
      model = ImageP()
      imagePickerController.delegate = self
      super.viewDidLoad()
      
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   
   
   
   
   
   
   
   
}// END NewProductViewController
