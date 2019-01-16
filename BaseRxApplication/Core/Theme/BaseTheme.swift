//
//  BaseTheme.swift
//  Seat
//
//  Created by Gary Dos Santos on 25/8/17.
//  Copyright © 2017. All rights reserved.
//

import UIKit

public protocol BaseStyle {
    
    var font: UIFont { get set }
    var textColor: UIColor { get set }
    var alignment: NSTextAlignment { get set }
    var backgroundColor: UIColor { get set }
    
}

public protocol ButtonStyle: BaseStyle {
    
    var highlightTextColor: UIColor? { get set }
    var selectedColor: UIColor? { get set }
    var borderColor: UIColor? { get set }
    var borderWidth: CGFloat { get set }
    var cornerRadius: CGFloat { get set }
    var image: UIImage? { get set }
    var isLink: Bool { get set }
}

public struct Style: ButtonStyle {
    
    public var font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    public var textColor = UIColor.gray
    public var highlightTextColor: UIColor? = nil
    public var selectedColor: UIColor? = nil
    public var borderColor: UIColor? = nil
    public var alignment = NSTextAlignment.left
    public var backgroundColor = UIColor.clear
    public var borderWidth: CGFloat = 0.0
    public var cornerRadius: CGFloat = 0.0
    public var image: UIImage? = nil
    public var placeholderColor: UIColor? = nil
    public var placeholderFont: UIFont? = nil
    public var isLink = false
    public var isSecure = false
    
    public init() {
    }
    
    public func textColor(_ textColor: UIColor) -> Style {
        var copy = self
        copy.textColor = textColor
        return copy
    }
    
    public func align(_ align: NSTextAlignment) -> Style {
        var copy = self
        copy.alignment = align
        return copy
    }
    
    public func image(_ image: UIImage) -> Style {
        var copy = self
        copy.image = image
        return copy
    }
    
    public func isSecure(_ isSecure: Bool) -> Style {
        var copy = self
        copy.isSecure = isSecure
        return copy
    }
    
    public func font(_ font: UIFont) -> Style {
        var copy = self
        copy.font = font
        return copy
    }
    
    public func backgroundColor(_ backgroundColor: UIColor) -> Style {
        var copy = self
        copy.backgroundColor = backgroundColor
        return copy
    }
    
    public func borderColor(_ borderColor: UIColor) -> Style {
        var copy = self
        copy.borderColor = borderColor
        return copy
    }
}
