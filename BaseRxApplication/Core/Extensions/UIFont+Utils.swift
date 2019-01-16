//
//  UIFont+Utils.swift
//  BaseRxApplication
//
//  Created by Gary  Dos Santos on 12/04/2018.
//  Copyright © 2018. All rights reserved.
//

import UIKit

extension UIFont {
    
    /// Get the font by the name of an assets that hold's the font,
    /// - parameters:
    ///     - name : the name of the font to load
    ///     - size : the real size of the font
    ///     - adjustSize : the size to adjust from original font depending of the device, the default one is 4.0
    /// - returns: UIColor with the rgb value
    public static func font(withName name: String? = nil, withSize size: CGFloat, withAdjustSize adjustSize: CGFloat = 4.0) -> UIFont {
        if let name = name, name.hasValue(), let font = UIFont(name: name, size: UIDevice.fontSizeByDevice(withSize: size, withSizeToAdjust: adjustSize)) {
            return font
        } else {
            return .systemFont(ofSize: UIDevice.fontSizeByDevice(withSize: size, withSizeToAdjust: adjustSize))
        }
    }
    
}
