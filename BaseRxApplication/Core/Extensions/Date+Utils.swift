//
//  Date+Utils.swift
//  OnionArchitecture
//
//  Created by Gary  Dos Santos on 11/08/2017.
//  Copyright © 2017. All rights reserved.
//

import UIKit

public extension Date {

    /// Return a String with the default dateFormat "yyyy-MM-dd  hh:mm"
    /// - parameters:
    ///     - format: format of the Date, default "yyyy-MM-dd"
    /// - returns: String of the Date with the respective format
    public func toString(withFormat format: String = "yy/MM/dd hh:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    /// Returns the amount of years from another date and the actual date
    /// - parameters:
    ///     - format: date to check difference years
    /// - returns: Int with the difference of years between them
    public func differenceYears(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: Date()).year ?? 0
    }
    
    /// Returns the amount of month from another date and the actual date
    /// - parameters:
    ///     - format: date to check difference month
    /// - returns: Int with the difference of month between them
    public func differenceMonths(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    
    /// Returns the amount of days from another date and the actual date
    /// - parameters:
    ///     - format: date to check difference days
    /// - returns: Int with the difference of days between them
    public func differenceDays(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0
    }
    
    /// Returns the amount of hours from another date and the actual date
    /// - parameters:
    ///     - format: date to check difference hours
    /// - returns: Int with the difference of hours between them
    public func differenceHours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    
    /// Returns the amount of minutes from another date and the actual date
    /// - parameters:
    ///     - format: date to check difference minutes
    /// - returns: Int with the difference of minutes between them
    public func differenceMinutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    /// Returns the amount of seconds from another date and the actual date
    /// - parameters:
    ///     - format: date to check difference seconds
    /// - returns: Int with the difference of seconds between them
    public func differenceSeconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    /// Check if the date is the same as the current day
    /// - returns: true if the date is today otherwise false
    public func isSameDay() -> Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    /// Check if the date is the same as tomorrow
    /// - returns: true if the date is tomorrow otherwise false
    public func isTomorrow() -> Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
    
    /// Check if the date is the same as yesterday
    /// - returns: true if the date is yestarday otherwise false
    public func isYesterday() -> Bool {
        return Calendar.current.isDateInToday(self)
    }
    
}
