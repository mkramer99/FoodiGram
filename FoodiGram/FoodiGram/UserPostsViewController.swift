//
//  UserPostsViewControllerCollectionViewController.swift
//  FoodiGram
//
//  Created by Melanie Kramer on 3/14/22.
//

import UIKit
import Foundation
import CoreData


class UserPostsViewController: UICollectionViewController {

    //var imagesArray: [UIImage] = []
    //var restaurantArray: [String] = []
    //var commentArray: [String] = []
    var postArray: [String] = []
    var image: UIImage!
    var name: String!
    var comment: String!
    var username: String!
    
    var whichLoadImages: String! = ""
    var deletePost: Bool!
    var objects: [NSManagedObject] = []
    //var object: NSManagedObject!
    var deletedIndex: Int!
    var buttonText: String!
    //var buttonSelected: String!

    override func viewDidLoad() {
        print("view did load")
        print(DeletePostBool.deletePost)
        if DeletePostBool.deletePost {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Post")
            do {
                let result = try context.fetch(fetch)
                for data in result as! [NSManagedObject] {
                    if (UserProfile.username == data.value(forKey: "username") as! String) {
                        print("username match")
                        //if (DeletePostBool.imagesArray[DeletePostBool.selectedIndex] == UIImage(data: data.value(forKey:"image") as! Data)) {
                            //print("image match")
                            if (DeletePostBool.commentArray[DeletePostBool.selectedIndex] == data.value(forKey: "comment") as! String)        {
                                print("comment match")
                                if(DeletePostBool.restaurantArray[DeletePostBool.selectedIndex] == data.value(forKey: "restaurant") as! String) {
                                    print("restaurant match")
                                    context.delete(data)
                                }
                            }
                        //}
                    }
                }
            }
            catch {
                print("error displaying image")
            }
            DeletePostBool.deletePost = false
            DeletePostBool.imagesArray.removeAll()
            DeletePostBool.restaurantArray.removeAll()
            DeletePostBool.commentArray.removeAll()
           
        }
        print(DeletePostBool.unlikePost)
        if DeletePostBool.unlikePost {
            print(DeletePostBool.selectedIndex, "selected index to unlike")
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Liked")
            do {
                let result = try context.fetch(fetch)
                for data in result as! [NSManagedObject] {
                    print(UserProfile.username)
                    print(data.value(forKey: "likedBy") as! String)
                    if (UserProfile.username == data.value(forKey: "likedBy") as! String) {
                        //if (DeletePostBool.imagesArray[DeletePostBool.selectedIndex] == UIImage(data: data.value(forKey:"image") as! Data)) {
                            //print("image match")
                            if (DeletePostBool.commentArray[DeletePostBool.selectedIndex] == data.value(forKey: "comment") as! String)        {
                                print("comment match")
                                if (DeletePostBool.restaurantArray[DeletePostBool.selectedIndex] == data.value(forKey: "restaurant") as! String) {
                                    print("restaurant match")
                                    //if (DeletePostBool.usernameArray[DeletePostBool.selectedIndex] == //data.value(forKey: "likedBy") as! String) {
                                        print("trying to unlike the data object")
                                        context.delete(data)
                                    //}
                                }
                            }
                        //}
                    }
                }
            }
            catch {
                print("error unliking image")
            }
            DeletePostBool.imagesArray.remove(at: DeletePostBool.selectedIndex)
            DeletePostBool.restaurantArray.remove(at: DeletePostBool.selectedIndex)
            DeletePostBool.commentArray.remove(at: DeletePostBool.selectedIndex)
            DeletePostBool.unlikePost = false
        }
        print(DeletePostBool.likePost)
        if DeletePostBool.likePost {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newEntity = NSEntityDescription.entity(forEntityName: "Liked", in: context)!
            let newPost = NSManagedObject(entity: newEntity, insertInto: context)
            // convert image to pngData
            let png = DeletePostBool.imagesArray[DeletePostBool.selectedIndex].pngData()
            print("liked by user: " , UserProfile.username)
            newPost.setValue(UserProfile.username, forKey: "likedBy")
            newPost.setValue(DeletePostBool.restaurantArray[DeletePostBool.selectedIndex], forKey: "restaurant")
            newPost.setValue(png, forKey: "image")
            newPost.setValue(DeletePostBool.commentArray[DeletePostBool.selectedIndex], forKey: "comment")
            //newPost.setValue(DeletePostBool.usernameArray[DeletePostBool.selectedIndex], forKey: "username")
            DeletePostBool.imagesArray.append(DeletePostBool.imagesArray[DeletePostBool.selectedIndex])
            DeletePostBool.restaurantArray.append(DeletePostBool.restaurantArray[DeletePostBool.selectedIndex])
            DeletePostBool.commentArray.append(DeletePostBool.commentArray[DeletePostBool.selectedIndex])
            DeletePostBool.usernameArray.append(DeletePostBool.usernameArray[DeletePostBool.selectedIndex])
            DeletePostBool.userArray.append(DeletePostBool.userArray[DeletePostBool.selectedIndex])
            do {
                try context.save()
                //saveSuccessAlert()
            } catch let error as NSError {
                print("Didn't save. \(error)")
            }
            DeletePostBool.likePost = false
            DeletePostBool.imagesArray.removeAll()
            DeletePostBool.restaurantArray.removeAll()
            DeletePostBool.commentArray.removeAll()
            DeletePostBool.usernameArray.removeAll()
            DeletePostBool.userArray.removeAll()
        }
        
        
        if (whichLoadImages == "list") {
            if (postArray.isEmpty) {
                print("empty")
            }
            else {
                loadMapImages()
            }
        }
        else {
            print("buttonSelected is: ")
            print(DeletePostBool.buttonSelected)
            if (DeletePostBool.buttonSelected == "post") {
                loadImages()
            }
            if (DeletePostBool.buttonSelected == "like") {
                loadLikes()
            }
            whichLoadImages = ""
        }
        postArray.removeAll()
        super.viewDidLoad()
        collectionView.delegate = self

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return DeletePostBool.imagesArray.count
    }
    // display post info when collectionviewcell selected
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
            image =  DeletePostBool.imagesArray[indexPath.item]
            name = DeletePostBool.restaurantArray[indexPath.item]
            comment = DeletePostBool.commentArray[indexPath.item]
        }
        DeletePostBool.selectedObject = objects[indexPath.item] as! NSManagedObject
        DeletePostBool.selectedIndex = indexPath.item as! Int
        performSegue(withIdentifier: "cellPopOver", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CollectionViewCellPopUp {
            let a = segue.destination as? CollectionViewCellPopUp
            a?.image = image
            let b = segue.destination as? CollectionViewCellPopUp
            b?.name = name
            let c = segue.destination as? CollectionViewCellPopUp
            c?.comment = comment
            let d = segue.destination as? CollectionViewCellPopUp
            d?.buttonVisible = DeletePostBool.deletePost
            let e = segue.destination as? CollectionViewCellPopUp
            e?.buttonText = buttonText
        }
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cellforitem")
        // Configure the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.configure(img: DeletePostBool.imagesArray[indexPath.item])
        return cell
    }
    
    func loadImages() {
        DeletePostBool.imagesArray.removeAll()
        DeletePostBool.restaurantArray.removeAll()
        DeletePostBool.commentArray.removeAll()
        buttonText = "delete"
        print("Load Images")
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Post")
        do {
            let result = try managedContext.fetch(fetch)
            for data in result as! [NSManagedObject] {
                if (UserProfile.username == data.value(forKey: "username") as! String) {
                    objects.append(data)
                    if let img = UIImage(data: data.value(forKey:"image") as! Data) {
                        DeletePostBool.imagesArray.append(img)
                        DeletePostBool.restaurantArray.append(data.value(forKey: "restaurant") as! String)
                        DeletePostBool.commentArray.append(data.value(forKey: "comment") as! String)
                    }
                }
            }
        }
        catch {
            print("error displaying image")
        }
    }
    
    func loadLikes() {
        DeletePostBool.imagesArray.removeAll()
        DeletePostBool.restaurantArray.removeAll()
        DeletePostBool.commentArray.removeAll()
        DeletePostBool.usernameArray.removeAll()
        DeletePostBool.userArray.removeAll()
        buttonText = "unlike"
        print("Load Likes")
        //DeletePostBool.deletePost = true
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Liked")
        do {
            let result = try managedContext.fetch(fetch)
            for data in result as! [NSManagedObject] {
                if (UserProfile.username == data.value(forKey: "likedBy") as! String) {
                    objects.append(data)
                    if let img = UIImage(data: data.value(forKey:"image") as! Data) {
                        DeletePostBool.imagesArray.append(img)
                        DeletePostBool.restaurantArray.append(data.value(forKey: "restaurant") as! String)
                        DeletePostBool.commentArray.append(data.value(forKey: "comment") as! String)
                        //DeletePostBool.usernameArray.append(data.value(forKey: "username") as! String)
                        DeletePostBool.userArray.append(data.value(forKey: "likedBy") as! String)
                    }
                }
            }
        }
        catch {
            print("error displaying image")
        }
        print(objects.count, "objects array count")
        print(DeletePostBool.imagesArray.count, "images array count")
    }
    func loadMapImages() {
        DeletePostBool.imagesArray.removeAll()
        DeletePostBool.restaurantArray.removeAll()
        DeletePostBool.commentArray.removeAll()
        DeletePostBool.userArray.removeAll()
        DeletePostBool.usernameArray.removeAll()
        buttonText = "like"
        print("Load Map Images")
        DeletePostBool.deletePost = false
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Post")
        do {
            let result = try managedContext.fetch(fetch)
            for data in result as! [NSManagedObject] {
                for post in postArray {
                    // if the coredata post (restaurant) is in the postArray
                    if (post == data.value(forKey: "restaurant") as! String) {
                        objects.append(data)
                        if let img = UIImage(data: data.value(forKey:"image") as! Data) {
                            DeletePostBool.imagesArray.append(img)
                            DeletePostBool.restaurantArray.append(data.value(forKey: "restaurant") as! String)
                            if let comment = (data.value(forKey: "comment") as? String)   {
                                DeletePostBool.commentArray.append(comment)
                            }
                            else {
                                DeletePostBool.commentArray.append("no comment")
                            }
                            DeletePostBool.userArray.append(UserProfile.username)
                            DeletePostBool.usernameArray.append((data.value(forKey: "username") as? String)!)
                        }
                        break
                    }
                }
            }
        }
        catch {
            print("error displaying image")
        }
        postArray.removeAll()
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
