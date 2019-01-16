//
//  UIView+ProgressHUD.swift
//  OnionArchitecture
//
//  Created by Gary Dos Santos on 14/08/2017.
//  Copyright © 2017. All rights reserved.
//

import UIKit
import MBProgressHUD

private var progressHUDCounterAssociationKey: UInt8 = 0

extension UIView {
    
    // ----------------------------
    // MARK: - Public methods 🔓
    // ----------------------------
    
    /// Method to show the Activity indicator loading progress
    /// - parameters:
    ///     - text : to display in the progress
    public func showProgressHUD(withLabelText text: String? = nil, withImages images: [UIImage]? = nil, withAnimationDuration duration: TimeInterval = 1.0, withBackgroundColor color: UIColor = UIColor.black.withAlphaComponent(0.7), withActivityIndicatorColor activityIndicatorColor: UIColor = .white, withCustomView customView: UIView? = nil, isFullMode: Bool = false) {
        guard progressHUDCounter == 0 else {
            progressHUDCounter += 1
            return
        }
        if let customView = customView {
            setupCustomView(withCustomView: customView, withBackgroundColor: color)
        } else if let images = images {
            setupAnimateContentView(withImages: images, withAnimationDuration: duration, withBackgroundColor: color)
        } else {
            setupDefaultIndeterminateProgress(withLabelText: text, withBackgroundColor: color, withActivityIndicatorColor: activityIndicatorColor, isFullMode: isFullMode)
        }
    }
    
    /// Method to hide the Activity indicator loading progress
    public func hideProgressHUD(isFullMode: Bool = false) {
        if progressHUDCounter > 0 {
            progressHUDCounter -= 1
            if progressHUDCounter == 0 {
                MBProgressHUD.hide(for: isFullMode ? self.window ?? self : self, animated: true)
            }
        }
    }
    
    // ----------------------------
    // MARK: - Private Func 🔐
    // ----------------------------
    
    private var progressHUDCounter: Int {
        get {
            if let counter = objc_getAssociatedObject(self, &progressHUDCounterAssociationKey) as? Int {
                return counter
            } else {
                objc_setAssociatedObject(self, &progressHUDCounterAssociationKey, 0, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
                return 0
            }
        }
        set(newValue) {
            objc_setAssociatedObject(self, &progressHUDCounterAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    private func setupAnimateContentView(withImages images: [UIImage], withAnimationDuration duration: TimeInterval = 1.0, withBackgroundColor color: UIColor) {
        if let animatedImages = UIImage.animatedImage(with: images, duration: duration) {
            let loadingNotification = MBProgressHUD.showAdded(to: self, animated: true)
            loadingNotification.mode = .customView
            loadingNotification.backgroundView.style = .solidColor
            loadingNotification.backgroundView.color = color
            loadingNotification.bezelView.color = UIColor.clear
            loadingNotification.bezelView.style = .solidColor
            loadingNotification.customView = UIImageView(image: animatedImages)
            loadingNotification.isSquare = true
        }
        progressHUDCounter += 1
    }
    
    private func setupDefaultIndeterminateProgress(withLabelText text: String? = nil, withBackgroundColor color: UIColor, withActivityIndicatorColor activityIndicatorColor: UIColor, isFullMode: Bool) {
        let loadingNotification = MBProgressHUD.showAdded(to: isFullMode ? self.window ?? self : self, animated: true)
        loadingNotification.mode = .indeterminate
        loadingNotification.backgroundView.style = .solidColor
        loadingNotification.backgroundView.color = color
        loadingNotification.bezelView.color = UIColor.clear
        loadingNotification.bezelView.style = .solidColor
        loadingNotification.activityIndicatorColor = activityIndicatorColor
        if let text = text {
            loadingNotification.label.text = text
        }
        progressHUDCounter += 1
    }
    
    private func setupCustomView(withCustomView customView: UIView, withBackgroundColor color: UIColor) {
        let loadingNotification = MBProgressHUD.showAdded(to: self, animated: true)
        loadingNotification.mode = .customView
        loadingNotification.backgroundView.style = .solidColor
        loadingNotification.backgroundView.color = color
        loadingNotification.bezelView.color = UIColor.clear
        loadingNotification.bezelView.style = .solidColor
        loadingNotification.customView = customView
        loadingNotification.isSquare = true
        progressHUDCounter += 1
    }
    
}
