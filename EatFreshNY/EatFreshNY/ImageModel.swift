import Foundation
import Firebase
import FirebaseStorage

class ImageModel {
   
   let storage = FIRStorage.storage()
   
   init() {}
   
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
