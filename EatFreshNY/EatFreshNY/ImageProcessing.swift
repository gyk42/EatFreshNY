//
//  ImageProcessing.swift
//  EatFreshNY
//
//  Created by oskar morett on 1/18/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

//
//  ImageProsessing.swift
//  textingImageFB
//
//  Created by oskar morett on 1/18/17.
//  Copyright © 2017 oskar morett. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

class ImageP {
   
   let storage = FIRStorage.storage()
   
   init() {}
   
   
   // SAVE image TO  FireBase
   func uploadImage(withData data: Data, named name: String) {
      
      let storageRef = storage.reference()
      let imageRef = storageRef.child(name)
      
      let _ = imageRef.put(data, metadata: nil) { (metadata, error) in
         guard let metadata = metadata else {
            return
         }
         let downloadURL = metadata.downloadURL
         print(downloadURL)
      }
   }
   
   
   
   // GEt image from Firebase
   func downloadImage(named name: String, complete: @escaping (UIImage?) -> ()) {
      
      let imageRef = storage.reference(withPath: name)
      imageRef.data(withMaxSize: 1 * 1024 * 1024) { data, error in
         
         if let data = data,
            let image = UIImage(data: data) {
            complete(image)
         }
      }
   }
}
