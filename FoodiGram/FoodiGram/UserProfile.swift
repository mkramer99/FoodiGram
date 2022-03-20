//
//  User.swift
//  FoodiGram
//
//  Created by Melanie Kramer on 1/23/22.
//

import Foundation

struct UserProfile {
    static var username: String = ""

    func getUsername() -> String {
        return UserProfile.username
    }
    func logout() {
        UserProfile.username = ""
        // segue back to login
        //performSegue(withIdentifier: "backToHome_Segue", sender: nil)
    }
    /*var id: Int;
    var firstName: String;
    var lastName: String;
    var bio: String;
    var picture: String;
    
    init(id:Int, firstName:String, lastName:String, bio:String, picture:String) {
        self.id = id;
        self.firstName = firstName;
        self.lastName = lastName;
        self.bio = bio;
        self.picture = picture;
    }*/
    
}
