//
//  Array+Utility.swift
//  Seat
//
//  Created by Gary  Dos Santos on 22/01/2018.
//  Copyright © 2018. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    /// Remove first collection element that is equal to the given `object`:
    public mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
    
    /// Control size array
    public mutating func append(_ newElement: Element, limit: Int) {
        guard let _ = index(of: newElement) else {
            if count == limit {
                removeLast()
            }
            insert(newElement, at: 0)
            return
        }
    }

}
