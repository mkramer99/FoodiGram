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

    var imagesArray: [UIImage] = []

    override func viewDidLoad() {
        loadImages()
        super.viewDidLoad()
        //collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        //collectionView.dataSource = self
        collectionView.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

   /* override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }*/


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imagesArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        // Configure the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
      
        //cell.imageView.image = imagesArray[indexPath.item]
        //let images = imagesArray[indexPath.row]
        //cell.imageView.image = UIImage(data: images)!
        
        //cell.imageView.image = images
        //cell.imageView.image = UIImage(named: "donut")
        //cell.configure(img: UIImage(named: "donut")!)
        cell.configure(img: imagesArray[indexPath.item])
        //cell.imageView.image = UIImage(named: "donut")!
        //cell.imageView.image = images
        //cell.cityNameLabel.text = city.name
        //cell.contentView.addSubview(imageview)
        return cell
    }
    
    func loadImages() {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Post")
        do {
            let result = try managedContext.fetch(fetch)
            for data in result as! [NSManagedObject] {
                if (UserProfile.username == data.value(forKey: "username") as! String) {
                    if let img = UIImage(data: data.value(forKey:"image") as! Data) {
                        //imagesArray.append(data.value(forKey: "image") as! Data)
                        imagesArray.append(img)
                        print(data.value(forKey: "restaurant") ?? "default")
                        print("images")
                        print(data.value(forKey: "image") ?? "image error")
                    }
                }
            }
            print(imagesArray)
        }
        catch {
            print("error displaying image")
        }
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
