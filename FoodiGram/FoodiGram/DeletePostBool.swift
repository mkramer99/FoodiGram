//
//  DeletePostBool.swift
//  FoodiGram
//
//  Created by Melanie Kramer on 4/4/22.
//

import Foundation
import CoreData
import UIKit


struct DeletePostBool {
    static var deletePost: Bool = false
    static var likePost: Bool = false
    static var unlikePost: Bool = false
    
    static var objects: [NSManagedObject] = []
    static var selectedObject: NSManagedObject!
    static var selectedIndex: Int!
    
    static var imagesArray: [UIImage] = []
    static var restaurantArray: [String] = []
    static var commentArray: [String] = []
    static var usernameArray: [String] = []
    static var userArray: [String] = []
    
    static var buttonSelected: String! = "post"
}
