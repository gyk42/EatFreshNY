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
        
    var selectedButton: UIButton?
    
    var categories: [String] = ["baked-goods", "dairy", "fruits", "preserves", "fish", "meat"]

    var categorySelected = ""
    
    
    
    
   @IBAction func logoutPressed(_ sender: Any) {
      UserModel.shared.logout()
   }
    
    //MARK:  VIEWCONTOLLER funcs
    override func viewDidLoad() {
        model = ImageP()
        imagePickerController.delegate = self
        super.viewDidLoad()
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
    
    // Main Product Photo
    @IBOutlet weak var addMainPhotoImage: UIImageView!
    @IBOutlet weak var mainPhotoOutlet: UIButton!
    @IBAction func mainPhotoButton(_ sender: UIButton) {
        
        selectedButton = sender
        pickImagePressed()
        
    }
    
    // in the UI from left to right  buttons  to add images
    @IBOutlet weak var addPhotoOneImage: UIImageView!
    @IBOutlet weak var onePhotoOutlet: UIButton!
    @IBAction func addPhotoOneButton(_ sender: UIButton) {
        selectedButton = sender
        pickImagePressed()
    }
    
    
    @IBOutlet weak var addPhotoTwoImage: UIImageView!
    @IBOutlet weak var twoPhotoOutlet: UIButton!
    @IBAction func addPhotoTwoButton(_ sender: UIButton) {
        selectedButton = sender
        pickImagePressed()
    }
    
    @IBOutlet weak var addPhotoThreeImage: UIImageView!
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
    
    var model: ImageP! // reference to ImageProcessing.swif (fireBase funcs)
   
   // to get rid of keyboard by touching the outside of the textfield
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
   }
   
    @IBAction func saveNewProductButtton(_ sender: UIButton) {
        
        //TEXT FIELDS:
        if let name = productNameTextfield.text, let description = productDescriptionTextfield.text, let price = productPrice.text, let quantity = qtyTextfield.text {
            ProductModel.shared.createProduct(name: name, image: imageName, description: description, price: price, quantity: quantity, category: categorySelected, userID: FIRAuth.auth()!.currentUser!.uid);
        }
      
        //PHOTOS:
        
        //Main Product Photo - save to Firebase with name look at  (imageName)
        uploadImage(image: addMainPhotoImage.image!, imageName: mainPhotoName)
        //one Product Photo - save to Firebase with name look at  (imageName)
        uploadImage(image: addPhotoOneImage.image!, imageName: onePhotoName)
        //two Product Photo - save to Firebase with name look at  (imageName)
        uploadImage(image: addPhotoTwoImage.image!, imageName: twoPhotoName)
        //two Product Photo - save to Firebase with name look at  (imageName)
        uploadImage(image: addPhotoThreeImage.image!, imageName: threePhotoName)
    
    }
    
    
    //MARK: FIREBASE  funcs
    
    // SAVE image TO  FireBas
    func uploadImage(image: UIImage, imageName: String ) {
        
        model.uploadImage(withData: UIImagePNGRepresentation(image)!, named: imageName)
        
    }
    
    // GEt image from Firebase
    func downloadImage(imageName: String) {
        
        model.downloadImage(named: imageName, complete: { image in
            
            if let i = image {
                // self.( ImageView to be conected).image = i
            }
        })
        
    }
    
    
    //MARK: IMAGE PICKER funcs
    
    let imagePickerController = UIImagePickerController()
    
    var mainPhotoName = " "
    var onePhotoName = " "
    var twoPhotoName = " "
    var threePhotoName = " "
    
    
    
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
        
        if selectedButton == mainPhotoOutlet {
            mainPhotoName = imageName
            addMainPhotoImage.image = image
            
        }
        else if selectedButton == onePhotoOutlet {
            
            onePhotoName = imageName
            addPhotoOneImage.image = image
        }
        else if selectedButton == twoPhotoOutlet {
            
            twoPhotoName = imageName
            addPhotoTwoImage.image = image
        }
            
        else if selectedButton == threePhotoOutlet {
            
            threePhotoName = imageName
            addPhotoThreeImage.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}// END NewProductViewController
