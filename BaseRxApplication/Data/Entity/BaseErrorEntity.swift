//
//  BaseErrorEntity.swift
//  BaseRxApplication
//
//  Created by Gary Dos Santos on 6/3/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import ObjectMapper

open class BaseErrorEntity: Error, Mappable {
    
    open var code: String = ""
    open var message: String = ""
    open var raw: String = ""
    open var title: String = ""
    
    public init() {}
    
    public required init?(map: Map) { }
    
    public init(code: String, message: String, raw: String) {
        self.code = code
        self.message = message
        self.raw = raw
    }
    
    open func mapping(map: Map) {
        code        <-  map["message"]
        message     <-  map["raw"]
        raw         <-  map["code"]
        title       <-  map["title"]
    }
    
}

extension BaseErrorEntity: MappableError {
    
    public func error() -> NSError {
        return NSError(
            domain: message,
            code: Int(code) ?? 0,
            userInfo: [NSLocalizedDescriptionKey: raw])
    }
    
}
