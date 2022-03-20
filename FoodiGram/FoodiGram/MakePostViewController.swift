//
//  MakePostViewController.swift
//  FoodiGram
//
//  Created by Melanie Kramer on 1/27/22.
//

import Foundation
import UIKit
import CoreLocation
import CoreData
import CryptoKit


class MakePostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    static let serviceName = "FoodiGramService"
    var backButton: UIButton!
    var locName: String = ""
    var locCoor: CLLocationCoordinate2D!
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var openPhotoLibrary: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var restaurantCoor: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantLabel.text = locName
        restaurantCoor.text = String(locCoor.latitude) + ", " + String(locCoor.longitude)
    }
    
    @IBAction func backButtonAction() {
        performSegue(withIdentifier: "backToHome_Segue", sender: nil)
    }
    @IBAction func takePhotoAction() {
        //if UIImagePickerController.isSourceTypeAvailable(.camera) {
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func openPhotoLibraryAction() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func saveButtonAction() {
        // save new post data
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newEntity = NSEntityDescription.entity(forEntityName: "Post", in: managedContext)!
        let newPost = NSManagedObject(entity: newEntity, insertInto: managedContext)
        // convert image to pngData
        let png = self.imagePicked.image?.pngData()
        newPost.setValue(UserProfile.username, forKey: "username")
        newPost.setValue(locName, forKey: "restaurant")
        newPost.setValue(locCoor.latitude, forKey: "latitude")
        newPost.setValue(locCoor.longitude, forKey: "longitude")
        newPost.setValue(png, forKey: "image")
        do {
            try managedContext.save()
            saveSuccessAlert()
            performSegue(withIdentifier: "backToHome_Segue", sender: nil)
        } catch let error as NSError {
            print("Didn't save. \(error)")
            performSegue(withIdentifier: "backToHome_Segue", sender: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
        imagePicked.image = image
        picker.dismiss(animated:true, completion: nil)
    }
    private func saveSuccessAlert() {
        let alert = UIAlertController(title: "Success!", message: "Post saved", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in self.performSegue(withIdentifier: "backToHome_Segue", sender: nil)
        } ))
        self.present(alert, animated: true, completion: nil)
      /*let alertView = UIAlertController(title: "Success!",
                                        message: "Post Saved",
                                        preferredStyle:. alert)
      let okAction = UIAlertAction(title: "Back To Map", style: .default)
      alertView.addAction(okAction)
      present(alertView, animated: true)*/
    }
}

