//
//  UIKitExtensions.swift
//  Extenz
//
//  Created by Jesse Hao on 2019/6/4.
//

import Foundation

public extension UIFont {
    class func pingFangSCFont(ofSize size:CGFloat, weight:UIFont.Weight) -> UIFont {
        var fontStr = "PingFangSC-"
        switch weight {
        case Weight.semibold:
            fontStr += "Semibold"
        case Weight.light:
            fontStr += "Light"
        case Weight.medium:
            fontStr += "Medium"
        case Weight.bold:
            fontStr += "Bold"
        case Weight.regular:
            fontStr += "Regular"
        default:
            fontStr += "Regular"
        }
        return UIFont(name: fontStr, size: size)!
    }
}
