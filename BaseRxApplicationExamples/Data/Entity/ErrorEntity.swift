//
//  ErrorEntity.swift
//  BaseRxApplicationExamples
//
//  Created by Gary Dos Santos on 6/3/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import BaseRxApplication
import ObjectMapper

final class ErrorEntity: BaseErrorEntity {
    
    override func mapping(map: Map) {
        code                        <-  map["code"]
        message                     <-  map["message"]
        raw                         <-  map["raw"]
    }
    
}
