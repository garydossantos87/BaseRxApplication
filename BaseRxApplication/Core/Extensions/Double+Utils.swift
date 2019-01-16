//
//  Double+Utils.swift
//  Seat
//
//  Created by Gary Dos Santos on 2/1/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

extension Double {
    
    /// Return a String with the default digits = 2
    /// - parameters:
    ///     - digits: amount of digits to show on the string
    /// - returns: String of the double with the digits amount
    public func toString(digits: Int = 2) -> String {
        return String(format: "%.\(digits)f", self)
    }    
}
