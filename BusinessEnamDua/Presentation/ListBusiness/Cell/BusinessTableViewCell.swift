//
//  BusinessTableViewCell.swift
//  BusinessEnamDua
//
//  Created by yxgg on 20/05/23.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureViews() {
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 16
        containerView.createShadow()
        
        photoImageView.layer.masksToBounds = true
        photoImageView.layer.cornerRadius = 16
    }
    
    func configureContent(business: Business.BusinessElement?) {
        photoImageView.loadImage(uri: business?.imageUrlImage)
        nameLabel.text = business?.name
        ratingLabel.text = "\(business?.rating ?? 0) ⭐️"
        priceLabel.text = business?.price
    }
}
