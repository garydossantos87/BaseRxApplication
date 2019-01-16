//
//  UIViewController+LocationManager.swift
//  BaseRxApplication
//
//  Created by Gary  Dos Santos on 09/04/2018.
//  Copyright © 2018. All rights reserved.
//

import UIKit
import CoreLocation
import CocoaLumberjack

public protocol LocationDelegate {
    
    func didUpdateLocations(locations: [CLLocation])
    func didFailWithError(didFailWithError error: Error)
}

extension UIViewController: CLLocationManagerDelegate {
    
    private struct LocationKeys {
        static var locationName = "cll_locationmanager"
        static var locationDelegate = "cll_delegate"
    }
    
    public var delegateLocation: LocationDelegate? {
        get {
            return objc_getAssociatedObject(self, &LocationKeys.locationDelegate) as? LocationDelegate
        }
        set {
            objc_setAssociatedObject(self, &LocationKeys.locationDelegate, newValue ?? nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var locationManager: CLLocationManager? {
        get {
            return objc_getAssociatedObject(self, &LocationKeys.locationName) as? CLLocationManager
        }
        set {
            objc_setAssociatedObject(self, &LocationKeys.locationName, newValue ?? nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// Check if the location permission is enabled otherwise call the handler
    /// - parameters:
    ///     - handler : block to allow showing a custom alert to notice the user that he need to enable location
    public func checkLocationPermissionStatus(completionLocationUnavailable handler: @escaping ()-> Void) {
        if self.locationManager == nil {
            self.locationManager = CLLocationManager()
        }
        
        if let locationManager = self.locationManager {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            if CLLocationManager.locationServicesEnabled() {
                switch CLLocationManager.authorizationStatus() {
                case .notDetermined:
                    locationManager.requestWhenInUseAuthorization()
                case .authorizedWhenInUse, .authorizedAlways:
                    locationManager.startUpdatingLocation()
                default:
                    handler()
                }
            } else {
                handler()
            }
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            self.delegateLocation?.didUpdateLocations(locations: locations)
            self.locationManager?.stopUpdatingLocation()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // TODO: Control when autorized first time // reload
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DDLogError("  \n**ERROR LOCATION -> \(error)\n")
        self.delegateLocation?.didFailWithError(didFailWithError: error)
    }
    
}
