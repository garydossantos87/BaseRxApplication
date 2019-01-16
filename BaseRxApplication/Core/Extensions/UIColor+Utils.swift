//
//  UIColor+Utils.swift
//  Seat
//
//  Created by Gary Dos Santos on 25/8/17.
//  Copyright © 2017. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// Get a UIColor from rgb value and alpha
    /// - parameters:
    ///     - rgbValue : the int value of color to get the UIColor
    ///     - alpha : alpha opacity of the color default value is 1.0 = 100%
    /// - returns: UIColor with the rgb value
    public class func rgb(rgbValue: UInt, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
}
