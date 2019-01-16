//
//  BaseUseCaseImpl.swift
//  BaseRxApplication
//
//  Created by Gary  Dos Santos on 05/03/2018.
//  Copyright © 2018. All rights reserved.
//

import Foundation

/** Base class to initialize the repository
 - parameters:
 - T: The parameter type of the repository
 */
open class BaseUseCaseImpl<T> {
    
    public let repository: T
    
    public init(repository: T) {
        self.repository = repository
    }
    
}
