//
//  BaseNavigationController.swift
//  Seat
//
//  Created by Gary  Dos Santos on 14/09/2017.
//  Copyright © 2017. All rights reserved.
//

import UIKit

open class BaseNavigationController: UINavigationController {
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
        
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStatusBarColor()
    }
    
    public func setupBackButton(withBackImage image: UIImage) {
        var backImage: UIImage? = nil
        if #available(iOS 11, *) {
            backImage = image.resizeWithWidth(width: 30.0)
            UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(5.0, -2.0), for: UIBarMetrics.default)
        } else {
            backImage = image.resizeWithWidth(width: 0.0)
            UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(5.0, 0.0), for: UIBarMetrics.default)
        }
        navigationBar.backIndicatorImage = backImage
        navigationBar.backIndicatorTransitionMaskImage = backImage
    }
    
    public func setupNavBar(backgroundImage: UIImage, tintColor: UIColor, titleFont: UIFont, shadowImage: UIImage = UIImage()) {
        var imageFrame = navigationBar.frame
        imageFrame.size.height += statusBarHeight()
        navigationBar.setBackgroundImage(backgroundImage, for: .default)
        navigationBar.shadowImage = shadowImage
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .black
        navigationBar.tintColor = tintColor
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font : titleFont]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.white], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.white], for: .selected)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.white], for: .highlighted)
    }
    
    private func setupStatusBarColor() {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    private func statusBarHeight() -> CGFloat {
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        return Swift.min(statusBarSize.width, statusBarSize.height)
    }
    
}
