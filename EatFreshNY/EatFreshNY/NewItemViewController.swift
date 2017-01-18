//
//  NewItemViewController.swift
//  EatFreshNY
//
//  Created by oskar morett on 1/18/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit

class NewItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
   
   
   var model: ImageP!
   
   // >>>>>>>>>>>>>>>>>>>>>>Image to FireBAse >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
   
   
   // SAVE image TO  FireBase
   
   @IBOutlet weak var saveImege: UIImageView! // not conected
   
   @IBAction func saveButton(_ sender: UIButton) {  // not conected
      
      uploadImage()
   }
   
   func uploadImage() {
      
      if let image = saveImege.image {
         model.uploadImage(withData: UIImagePNGRepresentation(image)!, named: "\(photoName)")
      }
   }
   
   
   
   // GEt image from Firebase
   
   @IBOutlet weak var getImage: UIImageView!
   
   @IBAction func getButton(_ sender: UIButton) {
      downloadImage()
   }
   
   func downloadImage() {
      
      model.downloadImage(named: "niM7azZS.png", complete: { image in
         
         if let i = image {
            self.getImage.image = i
         }
      })
      
   }
   
   
   //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ImagePicker  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   
   // let picker  =  ImagePicker()
   
   let imagePickerController = UIImagePickerController()
   var photoName = " "
   
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
      photoName = imageName
      saveImege.image = image
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
   
   
   
   
   
   
   
   
   
}// END ViewController
