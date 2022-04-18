//
//  CreateProfileViewController.swift
//  FoodiGram
//
//  Created by Melanie Kramer on 2/23/22.
//

import Foundation
import UIKit
import Crypto
import CoreData


class CreateProfileViewController: UIViewController {
    
    @IBOutlet var userNameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var createProfileButton: UIButton!
    @IBOutlet var backButton: UIButton!
    @IBOutlet weak var verifyPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonAction() {
        performSegue(withIdentifier: "backLogIn_Segue", sender: nil)
    }
    @IBAction func createProfileButtonAction() {
        view.endEditing(true)
        
        if (passwordField.text != verifyPasswordField.text) {
            showVerifyPasswordFailedAlert()
            passwordField.text = ""
            verifyPasswordField.text = ""
            return
        }
        guard let username = userNameField.text, userNameField.text!.count > 0 else {
            showLoginFailedAlert()
            return
        }
        // check for username duplicate
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let result = try managedContext.fetch(fetch)
            for data in result as! [NSManagedObject] {
                print(data)
                if (username == data.value(forKey: "username") as! String) {
                    showLoginFailedAlert()
                }
            }
        }
        catch {
            print("error fetching")
        }
        guard let password = passwordField.text, passwordField.text!.count > 0 else {
            showLoginFailedAlert()
            return
        }
        // create account
        do {
            try AuthorizationController.createProfile(username: username, password: password)
            performSegue(withIdentifier: "CreateProfileToHomeView_Segue", sender: nil)
            
        } catch {
            showLoginFailedAlert()
            return
        }
        
        //performSegue(withIdentifier: "CreateProfileToHomeView_Segue", sender: nil)
    }
    
    private func showLoginFailedAlert() {
      let alertView = UIAlertController(title: "Login Problem",
                                        message: "Username unavailable.",
                                        preferredStyle:. alert)
      let okAction = UIAlertAction(title: "Try Again!", style: .default)
      alertView.addAction(okAction)
      present(alertView, animated: true)
    }
    private func showVerifyPasswordFailedAlert() {
      let alertView = UIAlertController(title: "Login Problem",
                                        message: "Passwords do not match.",
                                        preferredStyle:. alert)
      let okAction = UIAlertAction(title: "Try Again!", style: .default)
      alertView.addAction(okAction)
      present(alertView, animated: true)
    }}
