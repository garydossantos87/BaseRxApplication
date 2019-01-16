//
//  BaseWireframe.swift
//  Seat
//
//  Created by Gary  Dos Santos on 05/09/2017.
//  Copyright © 2017. All rights reserved.
//

import UIKit
import Action
import CocoaLumberjack

open class BaseWireframe {
    
    weak public var presenterViewController: UIViewController!
    
    public init(){}
    
    /// Present the given view controller
    /// - parameters:
    ///     - viewController : to present on the navigation controller
    open func presentViewController(withViewController viewController: UIViewController) {
        guard presenterViewController != nil else { return }
        
        if let tabBarController = presenterViewController.tabBarController {
            tabBarController.present(viewController, animated: true, completion: nil)
        } else if let navigationController = presenterViewController.navigationController {
            navigationController.present(viewController, animated: true, completion: nil)
        } else {
            presenterViewController.present(viewController, animated: true, completion: nil)
        }
    }
    
    /// Pop the view controller existed in the Navigation
    open func popViewController() {
        guard presenterViewController != nil else { return }
        
        presenterViewController.navigationController?.popViewController(animated: true)
    }
    
    /// Push the given view controller
    /// - parameters:
    ///     - viewController : to push on the navigation controller
    open func pushViewController(withViewController viewController: UIViewController) {
        guard presenterViewController != nil else { return }
        
        if let navigationController = presenterViewController.navigationController {
            navigationController.pushViewController(viewController, animated: true)
        } else {
            DDLogError("  can`t push view controller, because navigation controller is nil\n")
        }
    }
    
    /// Create a rootViewController with the given ViewController, this will clean all the stack and add the viewController as root
    /// - parameters:
    ///     - viewController : to add like root
    open func rootViewController(withViewController viewController: UIViewController? = nil, withNavigationController navigationController: BaseNavigationController? = nil) {
        if let window = UIApplication.shared.keyWindow {
            if let navController = navigationController {
                window.rootViewController = navController
            } else {
                if let viewController = viewController {
                    window.rootViewController = BaseNavigationController(rootViewController: viewController)
                } else {
                    DDLogError("  can`t root view controller, because view controller is nil\n")
                }
            }
            window.backgroundColor = .white
            window.makeKeyAndVisible()
        } else {
            DDLogError("  can`t root view controller, because window is nil\n")
        }
    }
    
    /// Display tabbar custom
    /// - parameters:
    ///     - tabBarController : the tabbar controllers to show
    ///     - bgColor : Background color for uiwindow -optional-
    open func rootTabBarController(withController tabBarController: UITabBarController, withBackgroundColor bgColor: UIColor = UIColor.white) {
        if let window = UIApplication.shared.keyWindow {
            window.backgroundColor = bgColor
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        } else {
            DDLogError("  can`t tabbar view controller, because window is nil\n")
        }
    }
    
    /// Display multiples screens and only show the last with animation the previous one are only added to the stack.
    /// - parameters:
    ///     - viewControllers : the controllers to show
    open func rootMultiplesViewController(withControllers viewControllers: [UIViewController]) {
        guard presenterViewController != nil else { return }
        
        if let navigationController = presenterViewController.navigationController {
            navigationController.setViewControllers(viewControllers, animated: true)
        } else {
            DDLogError("  can`t root multiples view controller, navigation controller is nil\n")
        }
    }
    
    /// Dismiss a viewController
    /// - parameters:
    ///     - viewController : to be dismissed
    open func dismissViewController(withViewController viewController: UIViewController) {
        viewController.dismiss(animated: true)
    }
    
    /// Display multiples screens when showing Dialogs
    /// - parameters:
    ///     - viewController : Dialog to show
    open func presentDialogViewController(withViewController viewController: UIViewController) {
        guard presenterViewController != nil else { return }
        
        if let _ = presenterViewController.presentingViewController {
            presenterViewController.navigationController?.pushViewController(viewController, animated: true)
        } else if let presented = presenterViewController.presentedViewController as? BaseNavigationController {
            presented.pushViewController(viewController, animated: true)
        } else {
            let navigationDialogController = BaseNavigationController(rootViewController: viewController)
            navigationDialogController.modalPresentationStyle = .overCurrentContext
            presentViewController(withViewController: navigationDialogController)
        }
    }
    
    /// Dismiss present Dialog
    open func dismissDialogViewController() {
        guard presenterViewController != nil else { return }
        
        presenterViewController.dismiss(animated: true, completion: nil)
    }
    
}
