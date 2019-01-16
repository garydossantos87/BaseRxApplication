//
//  UIScrollView+Utils.swift
//  BaseRxApplication
//
//  Created by Gary Dos Santos on 9/4/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    public var currentPage: Int {
        return Int((contentOffset.x + (0.5 * frame.size.width)) / frame.width)
    }
    
    /// Scroll to a specific view so that it's top is at the top our scrollview
    public func scrollToView(view: UIView, animated: Bool) {
        if let origin = view.superview {
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            self.scrollRectToVisible(CGRect(x: 0.0, y: childStartPoint.y, width: 1.0, height: self.frame.height), animated: animated)
        }
    }
    
    /// Scroll to top
    public func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    /// Scroll to bottom
    public func scrollToBottom(animated: Bool) {
        let bottomOffset = CGPoint(x: 0.0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if bottomOffset.y > 0.0 {
            setContentOffset(bottomOffset, animated: animated)
        }
    }
    
}
