//
//  BaseEntity.swift
//  BaseRxApplication
//
//  Created by Gary  Dos Santos on 05/03/2018.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import ObjectMapper

open class BaseEntity: Mappable {
    
    public init() {}
    
    required public init?(map: Map) {
        
    }
    
    open func mapping(map: Map) {
        
    }
    
}
