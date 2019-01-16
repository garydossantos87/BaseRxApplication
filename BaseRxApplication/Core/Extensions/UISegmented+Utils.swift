//
//  UISegmented+Utility.swift
//  Seat
//
//  Created by Gary  Dos Santos on 14/11/2017.
//  Copyright © 2017. All rights reserved.
//

import UIKit

extension UISegmentedControl {
    
    /// Setup the appereance of a segmented control view
    /// - parameters:
    ///     - normalFont : the fount of the segmented control when the state is normal
    ///     - normalColor : the color of the segmented control when the state is normal
    ///     - highlightFont : the fount of the segmented control when the state is highlighted
    ///     - highlightColor : the color of the segmented control when the state is highlighted
    /// - returns: customized segmented control
    public func setupAppereance(normalFont: UIFont, normalColor: UIColor, highlightFont: UIColor, highlightColor: UIColor){
        let normalTextAttributes = [NSAttributedStringKey.foregroundColor: normalColor, NSAttributedStringKey.font: normalFont]
        let boldTextAttributes = [NSAttributedStringKey.foregroundColor : highlightColor, NSAttributedStringKey.font : highlightFont]
        
        setTitleTextAttributes(normalTextAttributes, for: .normal)
        setTitleTextAttributes(boldTextAttributes, for: .highlighted)
        setTitleTextAttributes(boldTextAttributes, for: .selected)
    }
    
}
