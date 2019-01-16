//
//  Error+Utils.swift
//  BaseRxApplication
//
//  Created by Gary Dos Santos on 6/3/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

extension Error {
    
    public func apiError() -> BaseErrorEntity {
        switch self {
        case let error as BaseErrorEntity:
            return error
        default:
            let error = self as NSError
            return BaseErrorEntity(code: String(error.code), message: self.localizedDescription, raw: error.domain)
        }
    }
    
}
