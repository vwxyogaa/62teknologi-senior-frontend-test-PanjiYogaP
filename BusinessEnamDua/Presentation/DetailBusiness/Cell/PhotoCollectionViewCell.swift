//
//  PhotoCollectionViewCell.swift
//  BusinessEnamDua
//
//  Created by yxgg on 21/05/23.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImageView.layer.cornerRadius = 20
        photoImageView.layer.masksToBounds = true
    }
    
    func configureContent(photo: String?) {
        photoImageView.loadImage(uri: photo)
    }
}
