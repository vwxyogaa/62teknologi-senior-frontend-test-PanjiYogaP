//
//  UIImageView+Ext.swift
//  BusinessEnamDua
//
//  Created by yxgg on 20/05/23.
//

import UIKit
import Kingfisher

// MARK: - Kingfisher Load Image
extension UIImageView {
    func loadImage(uri: String?, placeholder: UIImage? = nil) {
        guard let uri = uri, let uriImage = URL(string: uri) else { return }
        self.kf.setImage(with: uriImage, placeholder: placeholder)
    }
}
