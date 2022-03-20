//
//  LoginController.swift
//  FoodiGram
//
//  Created by Melanie Kramer on 1/24/22.
//

import Foundation
import UIKit
import Crypto


class LoginController: UIViewController {
    @IBOutlet var successfulLogin: UIButton!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var userNameField: UITextField!
    @IBOutlet var passwordField: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // ACTION BUTTON
    @IBAction func successfulLoginAction() {
        signIn()
        
        // segue to map home view after successful sign in
        //performSegue(withIdentifier: "loginToHomeView_Segue", sender: nil)
    }
    @IBAction func backButtonAction() {
        performSegue(withIdentifier: "backLogIn_Segue", sender: nil)
    }
    
    private func signIn() {
        view.endEditing(true)
        if (userNameField.text == "") {
            showLoginFailedAlert()
            return
        }
        //}
        //if (userNameField.text!.count > 0) {
        //    let username = userNameField.text
        //} else {
        //    showLoginFailedAlert()
        //    return
        //}
        let username = userNameField.text!
        let password = passwordField.text!
        //if (passwordField.text!.count > 0) {
        //    let password = passwordField.text
        //} else {
         //   showLoginFailedAlert()
         //   return
        //}
        do {
            print("sign in")
            if (AuthorizationController.signIn(username: username, password: password)) {
                performSegue(withIdentifier: "loginToHomeView_Segue", sender: nil)
            } else {
                showLoginFailedAlert()
        }
    }
    func showLoginFailedAlert() {
        let alertView = UIAlertController(title: "Login Problem",
                                        message: "Wrong username or password.",
                                        preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: nil)
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }
}
}
