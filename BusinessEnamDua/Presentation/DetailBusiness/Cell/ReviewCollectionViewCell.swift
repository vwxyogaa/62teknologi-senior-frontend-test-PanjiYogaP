//
//  ReviewCollectionViewCell.swift
//  BusinessEnamDua
//
//  Created by yxgg on 21/05/23.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var photoUserImageView: UIImageView!
    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var dateCreatedUserLabel: UILabel!
    @IBOutlet weak var descriptionReviewUserLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
        containerView.createShadow()
        photoUserImageView.layer.cornerRadius = photoUserImageView.frame.height / 2
        photoUserImageView.layer.masksToBounds = true
    }
    
    func configureContent(review: Reviews.Review?) {
        photoUserImageView.loadImage(uri: review?.user?.imageURL)
        nameUserLabel.text = review?.user?.name
        dateCreatedUserLabel.text = review?.timeCreated
        descriptionReviewUserLabel.text = review?.text
    }
}
