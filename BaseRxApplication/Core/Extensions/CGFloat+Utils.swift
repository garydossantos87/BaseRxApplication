//
//  CGFloat+Utility.swift
//  Seat
//
//  Created by Gary  Dos Santos on 27/10/2017.
//  Copyright © 2017. All rights reserved.
//

import UIKit

extension CGFloat {
    
    /// Transform the given timestamp to hours
    /// - returns: return a int with the hours of the given timestamp
    public func toHours() -> Int {
        return Int(self) / (60 * 60)
    }
    
    /// Transform the given timestamp to minutes
    /// - returns: return a int with the minutes of the given timestamp
    public func toMinutes() -> Int {
        return Int(self) / 60 % 60
    }
    
    /// Transform the given timestamp to seconds
    /// - returns: return a int with the seconds of the given timestamp
    public func toSeconds() -> Int {
        return ((toHours() * 60) + toMinutes()) * 60
    }
    
}
