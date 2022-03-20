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
    @IBOutlet weak var yourPostsButton: UIButton!
    @IBOutlet weak var likedPostsButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = UserProfile.username
        testImageView()
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
    func testImageView() {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Post")
        do {
            let result = try managedContext.fetch(fetch)
            for data in result as! [NSManagedObject] {
                /*if (data.value(forKey: "restaurant") as! String == "Oak and Stone") {
                    testImage.image = data.value(forKey: "image") as? UIImage
                }*/
                print(data.value(forKey: "restaurant") ?? "default")
                //testImage.image = data.value(forKey: "image") as? UIImage
                
            }
        }
        catch {
            print("error displaying image")
        }
    }
}
