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


// C7C17D2D-28A2-4292-928F-74A84F2FC0A2
// gs://eatfreshny-86172.appspot.com/C7C17D2D-28A2-4292-928F-74A84F2FC0A2.png
// gs://eatfreshny-86172.appspot.com/C7C17D2D-28A2-4292-928F-74A84F2FC0A2.png


// EBAC7CF5-AD0F-4287-83A8-EAF70E6A5E9F
// A0F89E04-CEF1-4933-902A-29D520F67ADE
// 566F95A7-AD6A-47CB-9093-7F3119663AFE


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
   
   // GEt image from Firebase as DAtA
   func downloadImage(named name: String, complete: @escaping (UIImage?) -> ()) {
      
      let imageRef = storage.reference(withPath: name)
      print(imageRef)
      imageRef.data(withMaxSize: 1 * 10024 * 2048) { data, error in
         
         if let data = data,
            let image = UIImage(data: data) {
            complete(image)
         }
      }
     /////
          
   }
}
