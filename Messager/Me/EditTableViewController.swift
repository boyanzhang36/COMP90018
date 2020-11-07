//
//  EditTableViewController.swift
//  Messager
//
//  Created by Boyang Zhang on 6/11/20.
//

import UIKit
import Firebase
import FirebaseUI
import IQKeyboardManagerSwift


class EditTableViewController: UITableViewController {
    let db = Firestore.firestore()
    let storage = Storage.storage()
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLocation: UITextField!
    // @IBOutlet weak var userIntro: UITextField!
    @IBOutlet weak var userIntro: UITextView!
    
    // MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()

        
        super.viewDidLoad()
        loadInfo()

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        
        tableView.separatorColor = .clear
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = false
    }
    
    
    // select image
    @IBAction func changePhoto(_ sender: UIButton) {
        // self.imagePicker.present(from: sender)
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // save -> update userInfo
    @IBAction func updateUserInfo(_ sender: Any) {
        guard let image = userImage.image else { print("no image selected"); return }
        guard let id = Auth.auth().currentUser?.uid else { return }
        guard let name = userName.text else { return }
        guard let location = userLocation.text else { return }
        guard let intro = userIntro.text else {return }
        
        let storageRef = Storage.storage().reference()
        let infoImageRef = storageRef.child("user-photoes")
        let query = db.collection("User").whereField("id", isEqualTo: id)
        query.getDocuments { [self] (querySnapshot, error) in
                    if let error = error {
                        print("Error getting documents: \(error)")
                    } else {
                        kCURRENTUSERNAME = name
                        var infoRef = db.collection("User").document()
                        var docID = infoRef.documentID
                        let imageID = docID + String(format: "%d", Int(NSDate().timeIntervalSince1970*100000))
                        if querySnapshot!.documents.count > 0 {
                            docID = querySnapshot!.documents[0].documentID
                            infoRef = db.collection("User").document(docID)
                        }
                        infoRef.updateData([
                            "location": location,
                            "intro": intro,
                            "avatarLink": imageID,
                            "username": name
                        ]) { err in
                            if let err = err {
                                print("Error adding document: \(err)")
                            } else {
                                print("Document added with ID: \(infoRef.documentID)")
                                uploadImage(from: image, to: imageID, completion: { () in
                                    self.navigationController?.popViewController(animated: true)
                                })

                            }
                        }
                    }
        }
        
        
        func uploadImage(from image: UIImage, to cloudName: String, completion:@escaping(() -> () )) {
            let cloudFileRef = infoImageRef.child(cloudName)
            guard let data = image.jpegData(compressionQuality: 1) else {completion() ;return }
        
            let uploadTask = cloudFileRef.putData(data, metadata: nil) { metadata, error in
                guard let _ = metadata else {return }
                completion()
            }
        }

        // uploadInfo()
        // uploadImage(from: image, to: infoDocID)
        
        
        // Segue back to Activity View
        
    }
    
    // MARK:-
    
    func loadInfo() {
        let user = Auth.auth().currentUser
        if let user = user {
            let userInfo = db.collection("User")
            let query = userInfo.whereField("id", isEqualTo: user.uid)
            query.getDocuments { [self] (querySnapshot, error) in
                        if let error = error {
                            print("Error getting documents: \(error)")
                        } else {
                            for document in querySnapshot!.documents {
                                let data = document.data()
                                let image = data["avatarLink"] as! String
                                let intro = data["intro"] as! String
                                let location = data["location"] as! String
                                let name = data["username"] as! String
                                self.userName.text = name
                                self.userIntro.text = intro
                                self.userLocation.text = location
                                let cloudFileRef = Storage.storage().reference(withPath: "user-photoes/"+image)
                                self.userImage.sd_setImage(with: cloudFileRef)

                            }
                        }
                    }
        }
    }
    
}

// MARK:- Delegate for Image Picker
extension EditTableViewController:  UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage  {
            self.userImage.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}


extension EditTableViewController: UINavigationControllerDelegate {
    
}

