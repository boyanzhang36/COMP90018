//
//  PostViewController.swift
//  Messager
//
//  Created by Boyang Zhang on 11/10/20.
//

import UIKit
import Firebase
import UITextView_Placeholder
import CoreLocation
<<<<<<< HEAD:Messager/Controller/PostViewController1.swift
=======
import IQKeyboardManagerSwift
import FirebaseFirestore

>>>>>>> 7ce313aaa1b6e71f525f03e397e6eb471d904ad3:Messager/Controller/PostViewController.swift

class PostViewController1: UIViewController {
    
    // Pop Up View
    var popup: UIView!

    
    // post activity related data
    var postCategory: String?
    var postImage: UIImage?
    var postTitle: String?
    var postDetail: String?
    var postLocation: CLLocation?
    var postLocationString: String?
<<<<<<< HEAD:Messager/Controller/PostViewController1.swift
    var postActStartDate: Date?
    var postActEndDate: Date?
=======
    
    var currentImageId: String?
    
>>>>>>> 7ce313aaa1b6e71f525f03e397e6eb471d904ad3:Messager/Controller/PostViewController.swift
    
    
    // IBOutlets
    @IBOutlet weak var activityImageView: UIImageView! {
        didSet {
            activityImageView.contentMode = .scaleAspectFill
            postImage = activityImageView.image
        }
    }
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var detailTextView: UITextView!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var postButton: UIButton!
    
    
    @IBOutlet weak var startDateField: UITextField!
    @IBOutlet weak var endDateField: UITextField! {
        didSet {
        }
    }
    
    
    @IBOutlet weak var startDateField: UITextField!
    @IBOutlet weak var endDateField: UITextField!
    
    
    // _
    private let imagePicker = UIImagePickerController()
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    var startDatePicker = UIDatePicker()
    var endDatePicker = UIDatePicker()
<<<<<<< HEAD:Messager/Controller/PostViewController1.swift

=======
>>>>>>> 7ce313aaa1b6e71f525f03e397e6eb471d904ad3:Messager/Controller/PostViewController.swift
    
    var postActStartDate: Date?
    var postActEndDate: Date?
    {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, d MMM yyyy HH:mm"
            endDateField.text = dateFormatter.string(from: endDatePicker.date)
        }
    }
    
    // MARK:- View Lifecycle
    // Override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup textView Placeholder stuff
        detailTextView.delegate = self
        
        detailTextView.text = "Activity Details here..."
        detailTextView.textColor = UIColor.lightGray
        
<<<<<<< HEAD:Messager/Controller/PostViewController1.swift
//        detailTextView.becomeFirstResponder()
//        detailTextView.selectedTextRange = detailTextView.textRange(from: detailTextView.beginningOfDocument, to: detailTextView.beginningOfDocument)
=======
>>>>>>> 7ce313aaa1b6e71f525f03e397e6eb471d904ad3:Messager/Controller/PostViewController.swift
        
        // Date Pickers
        startDatePicker.datePickerMode = .dateAndTime
        startDatePicker.preferredDatePickerStyle = .wheels
        endDatePicker.datePickerMode = .dateAndTime
        endDatePicker.preferredDatePickerStyle = .wheels
        
        // _. change input view of textfiled
        startDateField.inputView = startDatePicker
        endDateField.inputView = endDatePicker
        
        startDatePicker.addTarget(self, action: #selector(startDateChanged(datePicker:)), for: .valueChanged)
        endDatePicker.addTarget(self, action: #selector(endDateChanged(datePicker:)), for: .valueChanged)
        
<<<<<<< HEAD:Messager/Controller/PostViewController1.swift
        // __. init Start time and show on screen
        var nowDate = Date().advanced(by: 60*60*3)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:00"
=======
        startDatePicker.minuteInterval = 15
        endDatePicker.minuteInterval = 15
        
        // __. Set minimum Date for DatePicker()
        var nowDate = Date()
        startDatePicker.minimumDate = nowDate
        endDatePicker.minimumDate = nowDate.advanced(by: 60*15)
        
        // __. Init Start/End time and show on screen
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm"
        
//        nowDate = Date().nearestHour().advanced(by: 60*60*2)
        
>>>>>>> 7ce313aaa1b6e71f525f03e397e6eb471d904ad3:Messager/Controller/PostViewController.swift
        startDateField.text = dateFormatter.string(from: nowDate)
        postActStartDate = nowDate
        
        nowDate = nowDate.advanced(by: 60*60)
<<<<<<< HEAD:Messager/Controller/PostViewController1.swift
        endDateField.text = dateFormatter.string(from: nowDate)
        postActEndDate = nowDate
        
        startDatePicker.minimumDate = Date()
        endDatePicker.minimumDate = nowDate.advanced(by: -60*60)
        
        startDatePicker.minuteInterval = 15
        endDatePicker.minuteInterval = 15
=======
//        endDateField.text = dateFormatter.string(from: nowDate)
        postActEndDate = nowDate
        

        // For pass in Current Activity Information
        if let postLocationString = postLocationString{
            self.locationLabel.text = postLocationString
        }
        if let postTitle = postTitle {
            self.titleTextField.text = postTitle
        }
        if let postDetail = postDetail {
            self.detailTextView.text = postDetail
        }
        if let currentImageId = currentImageId {
            self.activityImageView.image = UIImage(named: currentImageId)
        }
        if let postCat = postCategory {
            self.categoryLabel.text = postCat
        }
        
>>>>>>> 7ce313aaa1b6e71f525f03e397e6eb471d904ad3:Messager/Controller/PostViewController.swift
    }
    
    @objc func startDateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm"
        
        startDateField.text = dateFormatter.string(from: datePicker.date)
        
        // limit startPicker range
        endDatePicker.minimumDate = startDatePicker.date.advanced(by: 60*15)
        postActStartDate = datePicker.date
        
        // TODO: 如果start date > end date， 自动更新end date
    }
    
    @objc func endDateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm"
        
        endDateField.text = dateFormatter.string(from: datePicker.date)
        
        postActEndDate = datePicker.date
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        if let category = postCategory {
            categoryLabel.text = category
        }
        
        setupUI()
        
        IQKeyboardManager.shared.enable = true  // for
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.shared.enable = false
    }
    
    func setupUI() {
        locationButton.setTitle("", for: [])
        postImage = nil
    }
    
    // MARK:- Date Picker
    @objc func startDateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm"
        
        startDateField.text = dateFormatter.string(from: datePicker.date)
        
        
        // Auto Update End Date if Start > End
        if datePicker.date > endDatePicker.date {
            endDatePicker.date = datePicker.date.advanced(by: 60*15)
            endDateField.text = dateFormatter.string(from: endDatePicker.date)
        }
        
        // limit startPicker range
        endDatePicker.minimumDate = startDatePicker.date.advanced(by: 60*15)
        postActStartDate = datePicker.date
        
    }
    
    @objc func endDateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm"
        
        endDateField.text = dateFormatter.string(from: datePicker.date)
        
        postActEndDate = datePicker.date
    }
    
    
    // MARK:- IBActions
    
    @IBAction func backBttnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chooseBttnTapped(_ sender: Any) {
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func postBttnTapped(_ sender: Any) {
<<<<<<< HEAD:Messager/Controller/PostViewController1.swift

=======
>>>>>>> 7ce313aaa1b6e71f525f03e397e6eb471d904ad3:Messager/Controller/PostViewController.swift
        
        self.view.endEditing(true)
        guard let image = postImage else {
            self.showAlert("No image selected")
            return
        }
        guard let userId = Auth.auth().currentUser?.uid else { return }
        guard let titleText = titleTextField.text else { return }
        guard titleText.count > 5 else {
            print("Title needs to be longer than 5")
            self.showAlert("Title needs to be more than 5 characters")
            return
        }
        guard let detailText = detailTextView.text else {return }
        guard detailText.count > 30 else {
            print("Detail needs to be longer than 30")
            self.showAlert("Detail needs to be more than 30 characters")

            return
        }
        self.showDino()
        
<<<<<<< HEAD:Messager/Controller/PostViewController1.swift
            
=======
>>>>>>> 7ce313aaa1b6e71f525f03e397e6eb471d904ad3:Messager/Controller/PostViewController.swift
        let actRef = db.collection(K.FStore.act).document()  // new Activity Document reference
        let storageRef = storage.reference()
        let activityImageRef = storageRef.child("activity-images")
        
        func uploadImage(from image: UIImage, to cloudName: String) {
            
            let cloudFileRef = activityImageRef.child(cloudName)
            
            guard let data = image.jpegData(compressionQuality: 1) else { return }  // data: image to be uploaded
            
            let _ = cloudFileRef.putData(data, metadata: nil) { metadata, error in
                guard let _ = metadata else { return }  // if metadata is nil, return
                
                self.dismissAlert()
                // Segue back to Activity View
                self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                self.dismiss(animated: true, completion: nil)
                
                print("Success upload image \(cloudName)")
            }
        }
        
        func uploadActivity() {
<<<<<<< HEAD:Messager/Controller/PostViewController1.swift
//            let act = Activity(uid: actRef.documentID, userId: userId,
//                               createDate: Date().timeIntervalSince1970, actTitle: titleText, actDetail: detailText,
//                               imageId: actRef.documentID)
=======
            
>>>>>>> 7ce313aaa1b6e71f525f03e397e6eb471d904ad3:Messager/Controller/PostViewController.swift
            var geoPoint: GeoPoint?
            if let location = postLocation {
                geoPoint = GeoPoint.init(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            }
            let readDic = [userId: 1]
<<<<<<< HEAD:Messager/Controller/PostViewController1.swift
            actRef.setData([
=======
            let join = [userId]
            
            actRef.setData([
                "actCreatorId": userId,
>>>>>>> 7ce313aaa1b6e71f525f03e397e6eb471d904ad3:Messager/Controller/PostViewController.swift
                "actDetail": detailText,
                "actTitle": titleText,
                "createDate": Date() as Any,
                "startDate": postActStartDate as Any,
                "endDate": postActEndDate as Any,
                "location": geoPoint as Any,
                "locationString": postLocationString as Any,
                "category": postCategory as Any,
                "imageId": actRef.documentID,
<<<<<<< HEAD:Messager/Controller/PostViewController1.swift
                "read_dic": readDic as Any
            ])

=======
                "read_dic": readDic as Any,
                "join": join as Any,
                "actStatus": 0, //0: awaiting, 1: ready, 2: finish
                "actGroupSize": 5,
            ])
            
>>>>>>> 7ce313aaa1b6e71f525f03e397e6eb471d904ad3:Messager/Controller/PostViewController.swift
            print("Activity Document added with ID: \(actRef.documentID)")
        }
        
        uploadActivity()
        uploadImage(from: image, to: actRef.documentID)
        
        
<<<<<<< HEAD:Messager/Controller/PostViewController1.swift
        // Segue back to Activity View
        self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
        self.dismiss(animated: true, completion: nil)
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPost2" {
            let destinationVC = segue.destination as! PostViewController2
            destinationVC.postImage = self.postImage
            destinationVC.postTitle = self.postTitle
            destinationVC.postDetail = self.postDetail
        }
        if segue.identifier == "toLocation" {
            let destinationVC = segue.destination as! PostLocationViewController
            destinationVC.delegate = self
        }
        
=======
>>>>>>> 7ce313aaa1b6e71f525f03e397e6eb471d904ad3:Messager/Controller/PostViewController.swift
    }
    
    
    @IBAction func locationBttnTapped(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let locationVC = storyboard.instantiateViewController(withIdentifier: "locationVC") as? PostLocationViewController else {  return }
        
        locationVC.delegate = self
        
        self.present(locationVC, animated: true, completion: nil)
    }
}


// MARK:- Delegate for Image Picker
extension PostViewController1:  UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage  {
            // update image view on page
            self.activityImageView.image = image
            
            //
            self.postImage = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

// MARK:- Select Location Delegate
<<<<<<< HEAD:Messager/Controller/PostViewController1.swift
extension PostViewController1: PostLocationDelegate {
=======
extension PostViewController: PostLocationDelegate {
>>>>>>> 7ce313aaa1b6e71f525f03e397e6eb471d904ad3:Messager/Controller/PostViewController.swift
    func updateLocation(location: CLLocation?, locString: String?) {
        print("!!!! Update Location Called")
        
        if let location = location, let locString = locString {
            postLocation = location
            postLocationString = locString
            locationLabel.text = locString
        } else {
            locationLabel.text = "Any Location"
        }
    }
}

// MARK:- Navigation Controller Delegate
extension PostViewController1: UINavigationControllerDelegate {
    
}


// MARK:-
extension PostViewController1: UITextViewDelegate {
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
<<<<<<< HEAD:Messager/Controller/PostViewController1.swift

=======
            
>>>>>>> 7ce313aaa1b6e71f525f03e397e6eb471d904ad3:Messager/Controller/PostViewController.swift
            textView.text = "Activity Details here..."
            textView.textColor = UIColor.lightGray
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
        
        // Else if the text view's placeholder is showing and the
        // length of the replacement string is greater than 0, set
        // the text color to black then set its text to the
        // replacement string
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }
        
        // For every other case, the text should change with the usual
        // behavior...
        else {
            return true
        }
        
        // ...otherwise return false since the updates have already
        // been made
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
    
}


// MARK:-
extension Date {
    func nearestHour() -> Date {
        return Date(timeIntervalSinceReferenceDate:
                (timeIntervalSinceReferenceDate / 3600.0).rounded(.toNearestOrEven) * 3600.0)
    }
}


extension PostViewController {
    func showAlert(_ alertText: String) {
        postButton.isEnabled = false
        
        popup = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
        popup.cornerRadius = 10
        
        let popIcon = UIImageView(frame: CGRect(x: 50, y: 20, width: 100, height: 100))
        popIcon.image = UIImage(named: "ic_close_48px")
        popIcon.alpha = 0.8
//        popup.addSubview(popIcon)
        
        let popLabel = UILabel(frame: CGRect(x: 10, y: 90, width: 180, height: 100))
        popLabel.numberOfLines = 0
        popLabel.text = alertText
        popLabel.font = UIFont(name: "Futura", size: 15)
        popLabel.textAlignment = .center
        popLabel.center = popup.center
        popup.addSubview(popLabel)
        
        popup.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        popup.center = view.center

        popup.layer.shadowColor = UIColor.black.cgColor
        popup.layer.shadowOpacity = 1
        popup.layer.shadowOffset = .zero
        popup.layer.shadowRadius = 200
        
        self.view.addSubview(popup)
        
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
        
    }
    
    func showDino() {
        postButton.isEnabled = false
        
        popup = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
        popup.cornerRadius = 10
        
        let popIcon = UIImageView(frame: CGRect(x: 50, y: 20, width: 100, height: 100))
        popIcon.image = UIImage(named: "dino3")
        popup.addSubview(popIcon)
        
        var gif_index = 1
        
        popup.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        popup.center = view.center
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            popIcon.image = UIImage(named: "dino\(gif_index)")
            gif_index += 1
            if gif_index > 3 {
                gif_index = 1
            }
        }
        
        self.view.addSubview(popup)
        

    }
    
    @objc func dismissAlert() {
        postButton.isEnabled = true

        if popup != nil {
            popup.removeFromSuperview()
        }
    }
    
    
}

