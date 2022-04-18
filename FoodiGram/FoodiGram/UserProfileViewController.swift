//
//  UserProfileViewController.swift
//  FoodiGram
//
//  Created by Melanie Kramer on 3/7/22.
//

import Foundation
import UIKit
import CoreData


class UserProfileViewController: UIViewController {
    @IBOutlet weak var logoutButton: UIButton!
    //@IBOutlet weak var testImage: UIImageView!
    var backButton: UIButton!
    var buttonSelect: String! = "post"
    @IBOutlet weak var yourPostsButton: UIButton!
    @IBOutlet weak var likedPostsButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = UserProfile.username
    }
    @IBAction func backButtonAction() {
        performSegue(withIdentifier: "userProfileBackToMap_Segue", sender: nil)
    }
    @IBAction func logoutButtonAction() {
        UserProfile.username = ""
        let alert = UIAlertController(title: "Success!", message: "Logged out", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in self.performSegue(withIdentifier: "logoutsegue", sender: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is UserPostsViewController {
            let a = segue.destination as? UserPostsViewController
            a?.deletePost = true
            let b = segue.destination as? UserPostsViewController
            //b?.buttonSelected = DeletePostBool.buttonSelected
        }
    }
    @IBAction func lourPosts(_ sender: Any) {
        DeletePostBool.buttonSelected = "post"
        print("changed to post")
    }
    @IBAction func likedPosts(_ sender: Any) {
        DeletePostBool.buttonSelected = "like"
        print("changed to like")
    }
}
