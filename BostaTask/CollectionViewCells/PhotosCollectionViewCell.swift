//
//  PhotosCollectionViewCell.swift
//  BostaTask
//
//  Created by Tawfik Sweedy✌️ on 4/20/22.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var Select : (()->())?

    @IBOutlet weak var img: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func selectAction(_ sender: Any) {
        Select?()
    }
}
