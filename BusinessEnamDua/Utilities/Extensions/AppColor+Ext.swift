//
//  AppColor+Ext.swift
//  BusinessEnamDua
//
//  Created by yxgg on 20/05/23.
//

import UIKit

private enum AppColor: String {
    case BEDBlack, BEDBlue, BEDGray, BEDGrayDark, BEDWhite
}

private extension AppColor {
    private func color(named: String) -> UIColor {
        return UIColor.defaultColor(named: named)
    }
    
    private var title: String {
        return self.rawValue
    }
    
    var color: UIColor {
        switch self {
        case .BEDBlack:
            return color(named: AppColor.BEDBlack.title)
        case .BEDBlue:
            return color(named: AppColor.BEDBlue.title)
        case .BEDGray:
            return color(named: AppColor.BEDGray.title)
        case .BEDGrayDark:
            return color(named: AppColor.BEDGrayDark.title)
        case .BEDWhite:
            return color(named: AppColor.BEDWhite.title)
        }
    }
}

let _defaultColors : [String:UIColor] = [
    "BEDBlack" : UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1),
    "BEDBlue" : UIColor(red: 118/255, green: 155/255, blue: 255/255, alpha: 1),
    "BEDGray" : UIColor(red: 250/255, green: 252/255, blue: 255/255, alpha: 1),
    "BEDGrayDark" : UIColor(red: 142/255, green: 142/255, blue: 142/255, alpha: 1),
    "BEDWhite" : UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
]

extension UIColor {
    static func defaultColor(named name: String, default defaultColor: UIColor = .black) -> UIColor {
        if #available(iOS 11, *) {
            return UIColor(named: name) ?? defaultColor
        }
        else {
            return _defaultColors[name] ?? defaultColor
        }
    }
    
    public class var BEDBlack: UIColor {
        return AppColor.BEDBlack.color
    }
    
    public class var BEDBlue: UIColor {
        return AppColor.BEDBlue.color
    }
    
    public class var BEDGray: UIColor {
        return AppColor.BEDGray.color
    }
    
    public class var BEDGrayDark: UIColor {
        return AppColor.BEDGrayDark.color
    }
    
    public class var BEDWhite: UIColor {
        return AppColor.BEDWhite.color
    }
}
