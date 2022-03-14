//
//  GalleryItemCollectionViewCell.swift
//  Photo Gallery
//
//  Created by Dhaval Dobariya on 11/03/22.
//

import UIKit

class GalleryItemCollectionViewCell: UICollectionViewCell {

    //MARK: Constants
    static let identifier = "GalleryItemCollectionViewCell"
    
    //MARK: IBOutlets
    @IBOutlet weak var galleryImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var galleryDescription: UILabel!
    
    //MARK: Cell Life Cycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
