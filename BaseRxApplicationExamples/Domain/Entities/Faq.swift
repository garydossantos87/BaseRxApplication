//
//  Faq.swift
//  BaseRxApplicationExamples
//
//  Created by Gary Dos Santos on 9/3/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import ObjectMapper

final class Faq: Mappable {
    
    var id: Int = 0
    var name: String = ""
    var content: String = ""
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    var status: Bool = false
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        content     <- map["content"]
        createdAt   <- (map["createdAt"], DateTransform())
        updatedAt   <- (map["updatedAt"], DateTransform())
        status      <- map["status"]
    }
    
}
