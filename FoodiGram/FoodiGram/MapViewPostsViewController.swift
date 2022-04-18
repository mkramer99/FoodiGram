//
//  MapViewPostsViewController.swift
//  FoodiGram
//
//  Created by Melanie Kramer on 3/29/22.
//

import UIKit
import Foundation
import CoreData


class MapViewPostsViewController: UICollectionViewController {
    var postArray: [String] = []
    var imagesArray: [UIImage] = []
    var restaurantArray: [String] = []
    var commentArray: [String] = []
    var image: UIImage!
    var name: String!
    var comment: String!
    
    override func viewDidLoad() {
        loadImages()
        super.viewDidLoad()
        collectionView.delegate = self
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Configure the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.configure(img: imagesArray[indexPath.item])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
            image =  imagesArray[indexPath.item]
            name = restaurantArray[indexPath.item]
            comment = commentArray[indexPath.item]
        }
        performSegue(withIdentifier: "cellPopOver2", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CollectionViewCellPopUp {
            let a = segue.destination as? CollectionViewCellPopUp
            a?.image = image
            let b = segue.destination as? CollectionViewCellPopUp
            b?.name = name
            let c = segue.destination as? CollectionViewCellPopUp
            c?.comment = comment
        }
    }
    func loadImages() {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Post")
        do {
            let result = try managedContext.fetch(fetch)
            for data in result as! [NSManagedObject] {
                for post in postArray {
                    if (post == data.value(forKey: "restaurant") as! String) {
                        imagesArray.append(data.value(forKey: "image") as! UIImage)
                        restaurantArray.append(data.value(forKey: "restaurant") as! String)
                        commentArray.append(data.value(forKey: "comment") as! String)                }
                }
            }
        }
        catch {
            print("error displaying image")
        }
    }
}
