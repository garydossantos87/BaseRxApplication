//
//  UIButton+Utils.swift
//  Seat
//
//  Created by Gary  Dos Santos on 20/09/2017.
//  Copyright © 2017. All rights reserved.
//

import UIKit

extension UIButton {
    
    /// Tint the image button with the color
    /// - parameters:
    ///     - image : to apply the tint
    ///     - color : to tint the image
    public func tintImageColor(image: UIImage, color: UIColor) {
        setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        tintColor = color
    }
    
    /// Create custom button from the style
    /// - parameters:
    ///     - style : to customize the button
    public func setup(withStyle style: ButtonStyle) {
        titleLabel?.font = style.font
        setTitleColor(style.textColor, for: .normal)
        if let highlightedColor = style.highlightTextColor {
            setTitleColor(highlightedColor, for: .highlighted)
        }
        if let selectedColor = style.selectedColor {
            setTitleColor(selectedColor, for: .selected)
        }
        
        if let image = style.image {
            let themeImage = image
            setImage(image.tint(withColor: style.textColor), for: .normal)
            if let highlightedColor = style.highlightTextColor {
                setImage(themeImage.tint(withColor: highlightedColor), for: .highlighted)
            }
            if let selectedColor = style.selectedColor {
                setImage(themeImage.tint(withColor: selectedColor), for: .selected)
            }
        }
    }
    
    /// Create custom button from the style
    /// - parameters:
    ///     - style : to customize the button
    public func setupBorder(withStyle style: ButtonStyle) {
        setup(withStyle: style)
        
        if let borderColor = style.borderColor {
            backgroundColor = style.backgroundColor
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = style.borderWidth
            layer.cornerRadius = style.cornerRadius
        }
    }
    
    /// Create custom button from the style
    /// - parameters:
    ///     - style : to customize the button
    public func setupWithBackgroundColorRounded(withStyle style: ButtonStyle) {
        titleLabel?.font = style.font
        setTitleColor(style.textColor, for: .normal)
        backgroundColor = style.backgroundColor
        layer.cornerRadius = style.cornerRadius
        layer.masksToBounds = true
        
        if let highlightedColor = style.highlightTextColor {
            setTitleColor(highlightedColor, for: .highlighted)
        }
        if style.isLink {
            let attributedText = self.titleLabel?.attributedText?.string
            let attributes = NSAttributedString(string: attributedText ?? "", attributes:[ NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue])
            setAttributedTitle(attributes, for: .normal)
        }
    }
    
    
    
}
