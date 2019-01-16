//
//  AppDelegate+UserNotificationCenter.swift
//  Seat
//
//  Created by Rodrigo Nunes on 5/2/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit
import UserNotifications
import CocoaLumberjack
import FTLinearActivityIndicator

public extension UIApplicationDelegate {
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    public func setupCocoaLumberJack() {
        let baseFormatter = BaseLogFormatter()
        DDTTYLogger.sharedInstance.logFormatter = baseFormatter
        DDLog.add(DDTTYLogger.sharedInstance) // TTY = Xcode console
    }
    
}
