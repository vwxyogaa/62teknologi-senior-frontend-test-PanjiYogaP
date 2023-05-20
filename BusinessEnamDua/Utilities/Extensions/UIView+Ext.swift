//
//  UIView+Ext.swift
//  BusinessEnamDua
//
//  Created by yxgg on 20/05/23.
//

import UIKit

// MARK: - Drop Shadow
extension UIView {
    public func createShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.BEDGrayDark.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
    }
    
    public func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    public func dropShadow(color: UIColor, opacity: Float = 0.5, offset: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

// MARK: - Shadow
public extension UIView {
    func applyShadow(
        color: UIColor = .BEDBlack,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / 2.0
        
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    func hardShadow(_ color: UIColor) {
        applyShadow(color: color, alpha: 0.1, x: 0, y: 16, blur: 20, spread: 1)
    }
    
    func mediumShadow(_ color: UIColor) {
        applyShadow(color: color, alpha: 0.1, x: 0, y: 16, blur: 20, spread: 1)
    }
    
    func softShadow(_ color: UIColor) {
        applyShadow(color: color, alpha: 0.1, x: 0, y: 2, blur: 8, spread: 0)
    }
    
    func leftShadow(_ color: UIColor) {
        applyShadow(color: color, alpha: 0.05, x: -7, y: 0, blur: 10, spread: 0)
    }
    
    func rightShadow(_ color: UIColor) {
        applyShadow(color: color, alpha: 0.05, x: 7, y: 0, blur: 10, spread: 0)
    }
}
