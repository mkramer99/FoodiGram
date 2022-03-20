//
//  CollectionViewCell.swift
//  FoodiGram
//
//  Created by Melanie Kramer on 3/15/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.image = UIImage(named: "donut")
    }
    
    public func configure(img: UIImage) {
        imageView.image = img
    }
}
