//
//  UIView+Utility.swift
//  Seat
//
//  Created by Gary  Dos Santos on 04/09/2017.
//  Copyright © 2017. All rights reserved.
//

import UIKit
import Action

extension UIView {
    
    /// Create a circular UIView
    public func makeCircular() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        self.clipsToBounds = true
    }
    
    /// Create a shadow to the UIView
    public func makeShadow(scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 10.0
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    /// Create a circular shadow to the UIView
    public func makeCircularDownShadow() {
        layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        layer.backgroundColor = UIColor.white.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 4.0
    }
    
    /// Create s snapshot of the current view of the phone/simulator
    public func snapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            if let img = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                return img
            }
        }
        return UIImage()
    }
    
    /// Create a elevate view
    public func elevate(backgroundColor: UIColor, shadowColor: CGColor, cornerRadius: CGFloat = 5.0) {
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOffset = CGSize(width: 0, height: 8.0)
        self.layer.shadowColor = shadowColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 8.0
        self.layer.masksToBounds = false
    }
    
    /// Create a round corners
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat = 5.0) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
        
    /// Create blur effect to a view
    /// - parameters:
    ///     - style : the type of style you want to assign to the blur
    public func blur(withBlurStyle style: UIBlurEffectStyle = .dark) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
    
}
