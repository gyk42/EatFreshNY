//
//  NewProductViewController.swift
//  EatFreshNY
//
//  Created by oskar morett on 1/18/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class NewProductViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
   var imageName = ""
   var selectedButton: UIButton? // it marks the presed button one to asisgn input to the rigth Image view and text
   var categories: [String] = ["baked-goods", "dairy", "fruits", "preserves", "fish", "meat"]
   var categorySelected = ""
   var imageNameOne = ""
   var imageNameTwo = ""
   var imageNameThree = ""
   var imageNameFour = ""

   
   var model: ImageP! // reference to ImageProcessing.swif (fireBase funcs)
   let imagePickerController = UIImagePickerController()
    
    //MARK:  VIEWCONTOLLER funcs

    override func viewDidLoad() {
      super.viewDidLoad()  
      model = ImageP()
      imagePickerController.delegate = self
      PickerCategories.dataSource = self
      PickerCategories.delegate = self
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //--------------------------------------------------------------------
    //MARK: CATEGORY SELECT BUTTON 
    
    @IBOutlet weak var PickerCategories: UIPickerView!
    
    @IBOutlet weak var CategoryPickerOutlet: UIButton!
    @IBAction func CategorySelected(_ sender: Any) {
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        CategoryPickerOutlet.setTitle(categories[row], for: UIControlState.normal)
        PickerCategories.isHidden = true
        categorySelected = categories[row]//
    }
    
    
    
    //--------------------------------------------------------------------
    //MARK: PHOTOS ///////////

   
//MARK: LOGOUT Button
   @IBAction func logoutPressed(_ sender: Any) {
      UserModel.shared.logout()
   }
   
   
   
   // to get rid of keyboard by touching the outside of the textfield
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
   }

    // Main Product Photo
    @IBOutlet weak var addImageOne: UIImageView!
    @IBOutlet weak var mainPhotoOutlet: UIButton!
    @IBAction func mainPhotoButton(_ sender: UIButton) {
      
        selectedButton = sender
        pickImagePressed()
      
    }
   
    // in the UI from left to right  buttons  to add images
    @IBOutlet weak var addImageTwo: UIImageView!
    @IBOutlet weak var onePhotoOutlet: UIButton!
    @IBAction func addPhotoOneButton(_ sender: UIButton) {
        selectedButton = sender
        pickImagePressed()
    }
   
   
    @IBOutlet weak var addImageThree: UIImageView!
    @IBOutlet weak var twoPhotoOutlet: UIButton!
    @IBAction func addPhotoTwoButton(_ sender: UIButton) {
        selectedButton = sender
        pickImagePressed()
    }
   
    @IBOutlet weak var addImageFour: UIImageView!
    @IBOutlet weak var threePhotoOutlet: UIButton!
    @IBAction func addPhotoThreeButton(_ sender: UIButton) {
        selectedButton = sender
        pickImagePressed()
    }
   
   
//MARK: TEXT INPUT
   
    // Outlets /////////
    @IBOutlet weak var productNameTextfield: UITextField!
    @IBOutlet weak var productDescriptionTextfield: UITextView!
    @IBOutlet weak var qtyTextfield: UITextField!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var productCategory: UILabel!
   
//MARK: SAVE BUTTON ( it will save  all phots and  all textField to firebase
    @IBAction func saveNewProductButtton(_ sender: UIButton) {

      
        // Save new Product Info into Firebase Database
        if let name = productNameTextfield.text,
         let description = productDescriptionTextfield.text,
         let price = productPrice.text, let quantity = qtyTextfield.text,
         let category = productCategory.text {
            ProductModel.shared.createProduct(name: name,
                                              imageOne: imageNameOne,
                                              imageTwo: imageNameTwo,
                                              imageThree: imageNameThree,
                                              imageFour: imageNameFour,
                                              description: description,
                                              price: price,
                                              quantity: quantity,
                                              category: category,
                                              userID: FIRAuth.auth()!.currentUser!.uid)
        }
      
        //ImageOne - save in Firebase STORAGE
        uploadImage(image: addImageOne.image!, imageName: imageNameOne)
        //ImageTwo - save in Firebase STORAGE
         uploadImage(image: addImageTwo.image!, imageName: imageNameTwo)
        //ImageThree - save in Firebase STORAGE
        uploadImage(image: addImageThree.image!, imageName: imageNameThree)
        //ImageFour - save in Firebase STORAGE
        uploadImage(image: addImageFour.image!, imageName: imageNameFour)
    
    }
   
   
//MARK: FIREBASE  funcs
   
    // SAVE image TO  FireBase STORAGE
    func uploadImage(image: UIImage, imageName: String ) {
      
        model.uploadImage(withData: UIImagePNGRepresentation(image)!, named: imageName)
      
    }
   
    // GEt image from Firebase Storage
   func GetImageFromStorage(imageName: String, imageView: UIImageView) {
      
        model.downloadImage(named: imageName, complete: { image in
         
            if let i = image {
               imageView.image = i
            }
        })
      
    }
   
   
//MARK: IMAGE PICKER funcs
   
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
    
   // It will Asign the image to the Rigth ImageView and A name to the Selected Photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
      
        
        if selectedButton == mainPhotoOutlet {
            imageNameOne = NSUUID().uuidString // creates a randome string to  be uses as photo name
            addImageOne.image = image
            print (imageNameOne)
        }
        else if selectedButton == onePhotoOutlet {
            
            imageNameTwo = NSUUID().uuidString // creates a randome string to  be uses as photo name
            addImageTwo.image = image
            print (imageNameTwo)

        }
        else if selectedButton == twoPhotoOutlet {
            
            imageNameThree = NSUUID().uuidString // creates a randome string to  be uses as photo name
            addImageThree.image = image
            print (imageNameThree)
        }
            
        else if selectedButton == threePhotoOutlet {
            
            imageNameFour = NSUUID().uuidString // creates a randome string to  be uses as photo name
            addImageFour.image = image
            print (imageNameFour)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}// END NewProductViewController
