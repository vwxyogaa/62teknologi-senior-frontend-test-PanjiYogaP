//
//  SortListBusinessCollectionViewCell.swift
//  BusinessEnamDua
//
//  Created by yxgg on 21/05/23.
//

import UIKit

class SortListBusinessCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 16
        containerView.layer.borderColor = UIColor.BEDBlack.cgColor
        containerView.layer.shadowOffset = CGSize(width: 10, height: 10)
        containerView.layer.shadowRadius = 3
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowColor = UIColor.BEDBlack.cgColor
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                containerView.backgroundColor = .BEDBlue
                containerView.layer.borderColor = UIColor.BEDGray.cgColor
                nameLabel.textColor = .BEDWhite
            } else {
                containerView.backgroundColor = .BEDWhite
                containerView.layer.borderColor = UIColor.BEDGray.cgColor
                nameLabel.textColor = .BEDBlack
            }
        }
    }
    
    func configureContent(name: String) {
        nameLabel.text = name
    }
}
