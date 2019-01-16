//
//  String+Utils.swift
//  OnionArchitecture
//
//  Created by Gary  Dos Santos on 10/08/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /// Check if a string contains a Int
    /// - returns: boolean indicated if the string contains a Int
    public var isInt: Bool {
        return Int(self) != nil
    }
    
    /// Return attributed string from actual text (or content)
    /// - returns: formated string or nil
    public var htmlToAttributedString: NSMutableAttributedString? {
        guard let data = data(using: String.Encoding.utf8) else { return nil }
        
        do {
            return try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html,.characterEncoding: String.Encoding.utf8.rawValue],documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    /// Check whether the given String has actual text.
    /// - returns: true if the string has value otherwise false
    public func hasValue() -> Bool {
        return !self.isEmpty && self != "null" && self != "nil"
    }
    
    /// Check whether the given URL is valid.
    /// - returns: true if the url is valid otherwise false
    public func validURL() -> Bool {
        if self.hasValue(), let url = URL(string: self) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    /// Return a valid Float from a String.
    /// - returns: true if the url is valid otherwise false
    public func toFloat() -> Float? {
        if self.hasValue(), let floatValue = Float(self) {
            return floatValue
        }
        return nil
    }
    
    /// Return a valid Date from a String with the default dateFormat "yyyy-MM-dd"
    /// - parameters:
    ///     - format: To transform the Date, default "yyyy-MM-dd"
    /// - returns: Date if the String is valid otherwise nil
    public func toDate(withFormat format: String? = "yyyy-MM-dd") -> Date? {
        if self.hasValue() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            return dateFormatter.date(from: self)
        }
        return nil
    }
    
    /// Validates a given e-mail
    /// - parameters:
    ///     - mail : The given e-mail to be evaluated.
    /// - returns: Bool
    public func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    /// Validates a spain postal code
    /// - parameters:
    ///     - postalCode : The given postalCode to be evaluated.
    /// - returns: Bool
    public func validateSpainPostalCode() -> Bool {
        let emailRegex = "[0-9]{4,5}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    /// Validates a given phone number
    /// - parameters:
    ///     - minimumSize : The minimum size that should have. Default is 6
    //      - maximumSize : The maximum size that should have. Default is 14
    /// - returns: Bool indicating if the phone number is valid
    public func validatePhoneNumber(minimumSize: String = "6", maximumSize: String = "14") -> Bool {
        let phoneRegex = "^[0-9]{\(minimumSize),\(maximumSize)}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: self)
    }
    
    /// Get the width size of a string
    /// - parameters:
    ///     - font : The font of the string
    /// - returns: CGFloat with the width size of the string
    public func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    /// Get the height size of a string
    /// - parameters:
    ///     - font : The font of the string
    /// - returns: CGFloat with the height size of the string
    public func heigthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
}

