//
//  AuthorizationController.swift
//  FoodiGram
//
//  Created by Melanie Kramer on 1/24/22.
//

import Foundation
import Crypto
import Security
import UIKit
import CoreData


class AuthorizationController {
    // name to identify the data in the keychain
    static let serviceName = "FoodiGramService"
    var passwordItems: [KeychainPasswordItem] = []
    
    // store login info into the keychain
    class func signIn(username: String, password: String) -> Bool {
        // hash the password
        let finalHash = passwordHash(from: username, password: password)
        //try KeychainPasswordItem(service: serviceName, account: username).savePassword(finalHash)
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let result = try managedContext.fetch(fetch)
            for data in result as! [NSManagedObject] {
                if (username == data.value(forKey: "username") as! String) {
                    if (finalHash == data.value(forKey: "password") as! String) {
                        UserProfile.username = username
                        return true
                    }
                }
                else {
                    continue
                }
            }
            return false
        } catch {
            print("error fetching")
        }
        return false
    }
    
    class func createProfile(username: String, password: String) throws {
        // create hashed password
        let finalHash = passwordHash(from: username, password: password)
        // create new keychain item with the account name
        //let passwordItem = KeychainPasswordItem(service: serviceName, account: username, accessGroup: nil)
        // save password to the new item
        //try passwordItem.savePassword(finalHash)
        //UserDefaults.standard.set(true, forKey: "hasLoginKey")        // CoreData
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        let newUser = NSManagedObject(entity: newEntity, insertInto: managedContext)
        newUser.setValue(username, forKey: "username")
        newUser.setValue(finalHash, forKey: "password")
        do {
            try managedContext.save()
            UserProfile.username = username
        } catch let error as NSError {
            print("Didn't save. \(error)")
        }
    }
    
    // takes email/password and returns hashed string
    // https://www.hackingwithswift.com/example-code/cryptokit/how-to-calculate-the-sha-hash-of-a-string-or-data-instance
    class func passwordHash(from username: String, password: String) -> String {
        let salt = "x4vV8bGgqqmQwgCoyXFQj+(o.nUNQhVP7ND"
        let hashString = password + username + salt
        let inputData = Data(hashString.utf8)
        let hashed = SHA256.hash(data: inputData)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
    
}
