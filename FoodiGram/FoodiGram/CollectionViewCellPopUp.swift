//
//  CollectionViewCellPopUp.swift
//  FoodiGram
//
//  Created by Melanie Kramer on 3/28/22.
//

import Foundation
import UIKit
import CoreData
import CoreLocation


class CollectionViewCellPopUp: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var postTextView: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    var image: UIImage!
    var name: String!
    var comment: String!
    @IBOutlet weak var deleteButton: UIButton!
    var buttonVisible: Bool = true
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var unlikeButton: UIButton!
    var buttonText: String!
    
    
    override func viewDidLoad() {
        imageView.image = image
        restaurantNameLabel.text = name
        postTextView.text = comment
        //if (!buttonVisible) {
        if (buttonText == "like") {
            deleteButton.isHidden = true
            unlikeButton.isHidden = true
            likeButton.isHidden = false
        }
        if (buttonText == "delete") {
            likeButton.isHidden = true
            unlikeButton.isHidden = true
            deleteButton.isHidden = false
        }
        if (buttonText == "unlike") {
            likeButton.isHidden = true
            deleteButton.isHidden = true
            unlikeButton.isHidden = false
        }
    }
    @IBAction func deleteButtonFunc() {
        let alert = UIAlertController(title: "Success!", message: "Post deleted", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
        } ))
        self.present(alert, animated: true, completion: nil)
        DeletePostBool.deletePost = true
        //self.dismiss(animated: false)
    }
    @IBAction func likePostButtonFunc() {
        let alert = UIAlertController(title: "Success!", message: "Post liked", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
        } ))
        self.present(alert, animated: true, completion: nil)
        DeletePostBool.likePost = true
        //self.dismiss(animated: false)
    }
    @IBAction func unlikeButtonFunc(_ sender: Any) {
        let alert = UIAlertController(title: "Success!", message: "Post unliked", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
        } ))
        self.present(alert, animated: true, completion: nil)
        DeletePostBool.unlikePost = true
        //self.dismiss(animated: false)
        
    }
}
