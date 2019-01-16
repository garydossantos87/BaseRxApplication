//
//  UILabel+Utils.swift
//  BaseRxApplication
//
//  Created by Gary  Dos Santos on 02/03/2018.
//  Copyright © 2018. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// Create custom label from the style
    /// - parameters:
    ///     - style : to customize the button
    public func setup(withStyle style: BaseStyle) {
        backgroundColor = style.backgroundColor
        font = style.font
        textColor = style.textColor
        textAlignment = style.alignment
    }
    
    /// Create custom label from the style
    /// - parameters:
    ///     - style : to customize the label
    public func setupBorder(withStyle style: ButtonStyle) {
        setup(withStyle: style)
        
        if let borderColor = style.borderColor {
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = style.borderWidth
            layer.cornerRadius = style.cornerRadius
        }
    }
    
}
