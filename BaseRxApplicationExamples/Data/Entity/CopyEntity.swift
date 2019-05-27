//
//  CopyEntity.swift
//  BaseRxApplicationExamples
//
//  Created by  on 22/09/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import ObjectMapper

final class CopyEntity: Mappable {
    
    var id: Int? = nil
    var name: String? = nil
    var content: String? = nil
    var createdAt: Double? = nil
    var updatedAt: Double? = nil
    var status: Bool? = nil
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        content     <- map["content"]
        createdAt   <- map["createdAt"]
        updatedAt   <- map["updatedAt"]
        status      <- map["status"]
    }
    
}

