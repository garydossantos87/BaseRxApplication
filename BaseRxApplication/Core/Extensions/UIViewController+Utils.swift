//
//  UIViewController+Utils.swift
//  Seat
//
//  Created by Gary  Dos Santos on 08/09/2017.
//  Copyright © 2017. All rights reserved.
//

import UIKit
import TTGSnackbar
import CocoaLumberjack
import MessageUI

public enum Visibility { case visible, gone }

extension UIViewController: MFMailComposeViewControllerDelegate {
    
    public func progressVisibility(visibility: Visibility, withLabelText text: String? = nil, withImages images: [UIImage]? = nil, withAnimationDuration duration: TimeInterval = 1.0, withBackgroundColor color: UIColor = UIColor.black.withAlphaComponent(0.7), withActivityIndicatorColor activityIndicatorColor: UIColor = UIColor.white, withCustomView customView: UIView? = nil, isFullMode: Bool = true) {
        progressStatusBarVisibility(visibility: visibility)
        switch visibility {
        case .visible:
            self.view.showProgressHUD(withLabelText: text, withImages: images, withAnimationDuration: duration, withBackgroundColor: color, withActivityIndicatorColor: activityIndicatorColor, withCustomView: customView, isFullMode: isFullMode)
        case .gone:
            self.view.hideProgressHUD(isFullMode: isFullMode)
        }
    }
    
    public func progressStatusBarVisibility(visibility: Visibility) {
        switch visibility {
        case .visible:
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        case .gone:
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        setNeedsStatusBarAppearanceUpdate()
    }
    
    public func showAlert(error: BaseErrorEntity) {
        showAlertController(title: "unexpected_error_title".localized, message: error.message, buttonTitle: "accept".localized, style: .cancel)
    }
    
    public func showAlertController(title: String?, message: String, buttonTitle: String?, buttonAction: UIAlertAction? = nil, style: UIAlertActionStyle? = .cancel, secondButton: UIAlertAction? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let buttonAction = buttonAction {
            alertController.addAction(buttonAction)
        } else {
            let defaultAction = UIAlertAction(title: buttonTitle, style: style ?? .cancel, handler: nil)
            alertController.addAction(defaultAction)
        }
        
        if let secondButton = secondButton {
            alertController.addAction(secondButton)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// Create and show a Snakbar
    /// - parameters:
    ///     - message : text to show on the snackBar
    ///     - duration : time of showing the snackBar (default = .middle)
    ///     - color : background color of the snackBar (default = UIColor.black.withAlphaComponent(0.5))
    public func showSnackBar(withMessage message: String, withDuration duration: TTGSnackbarDuration = .middle, withBackgroundColor color: UIColor = UIColor.black.withAlphaComponent(0.5)) {
        let snackbar = TTGSnackbar(message: message, duration: duration)
        snackbar.backgroundColor = color
        snackbar.show()
    }
    
    /// Add a child ViewController to a parent ViewController through a ContainerView
    /// - parameters:
    ///     - viewController : the child to be add it to the view
    ///     - containerView : the view that will hold the ViewController
    public func addChildViewController(withViewController viewController: UIViewController, withContainerView containerView: UIView) {
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.view.translatesAutoresizingMaskIntoConstraints = true
        viewController.willMove(toParentViewController: self)
        addChildViewController(viewController)
        containerView.autoresizesSubviews = true
        containerView.addSubview(viewController.view)
    }
    
    /// Remove a child ViewController to a parent ViewController through a ContainerView
    /// - parameters:
    ///     - viewController : the child to be remove it from the view
    public func removeChildViewController(withViewController viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
    
    /// Launch Google maps Third Party app
    /// - parameters:
    ///     - address : the child to be remove it from the view
    ///     - zoom : level of zoom to open google maps
    ///     - views : type to show the map (example: traffic)
    public func launchGoogleMaps(address: String) {
        if let urlGoogleMaps = URL(string:"comgooglemaps://"), UIApplication.shared.canOpenURL(urlGoogleMaps) {
            if let url = URL(string: "comgooglemaps://?q=\(address)&zoom=14&views=traffic") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            print("Can't use comgooglemaps://");
        }
    }
    
    /// Launch Phone Third Party app
    /// - parameters:
    ///     - number : the number to call
    public func launchPhone(withNumber number: String) {
        if let url = URL(string:"tel://\(number.replacingOccurrences(of: " ", with: "")))") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            DDLogError("  \n**ERROR -> Can´t open phone call app \n")
        }
    }
    
    /// Send Mail Third Party app
    /// - parameters:
    ///     - recipients : the people to send the mail
    ///     - subject : subject of the mail
    ///     - message : the body/content of the mail
    ///     - isHTML : boolean that indicate if the body/message is HMTL
    public func sendMail(recipients: [String] = [], subject: String = "", message: String = "", isHTML: Bool = false) {
        guard MFMailComposeViewController.canSendMail() else {
            DDLogError("  \n**ERROR -> Can´t send mail \n")
            return
        }
        
        let mailComposeViewController = configuredMailComposeViewController(recipients: recipients, subject: subject, message: message, isHTML: isHTML)
        self.present(mailComposeViewController, animated: true, completion: nil)
    }
    
    /// Launch Mail Third Party app
    public func launchMail() {
        if let url = URL(string: "message://") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            DDLogError("  \n**ERROR -> Can´t open mail app \n")
        }
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    private func configuredMailComposeViewController(recipients: [String], subject: String, message: String, isHTML: Bool) -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(recipients)
        mailComposerVC.setSubject(subject)
        mailComposerVC.setMessageBody(message, isHTML: isHTML)
        
        return mailComposerVC
    }
    
}
