//
//  UITableView+Ext.swift
//  BusinessEnamDua
//
//  Created by yxgg on 20/05/23.
//

import UIKit

extension UITableView {
    static let contentSizeKeyPath = "contentSize"
    
    func setBackground(imageName: String, imageMessage: String?) {
        let parentView = UIView()
        parentView.frame = self.frame
        
        lazy var imageView: UIImageView = {
            let image = UIImageView()
            image.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
            image.image = UIImage(named: imageName)
            return image
        }()
        
        lazy var imageMessageLabel: UILabel = {
            let label = UILabel()
            label.text = imageMessage ?? ""
            label.font = .systemFont(ofSize: 14, weight: .regular)
            label.textColor = .gray
            label.numberOfLines = 0
            label.textAlignment = .center
            return label
        }()
        
        lazy var verticalStackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .center
            stack.spacing = 15
            return stack
        }()
        
        lazy var horizontalStackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .center
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        verticalStackView.addArrangedSubview(imageView)
        verticalStackView.addArrangedSubview(imageMessageLabel)
        horizontalStackView.addArrangedSubview(verticalStackView)
        parentView.addSubview(horizontalStackView)
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 15),
            horizontalStackView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -15),
            horizontalStackView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 0),
            horizontalStackView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: 0)
        ])
        
        self.backgroundView = parentView
        self.separatorStyle = .none
        self.isScrollEnabled = false
    }
    
    func clearBackground(separator: UITableViewCell.SeparatorStyle = .none) {
        self.backgroundView = nil
        self.separatorStyle = separator
        self.isScrollEnabled = true
    }
}
