//
//  BaseRequestAdapter.swift
//  BaseRxApplication
//
//  Created by Gary Dos Santos on 23/5/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import Alamofire
import CocoaLumberjack

open class BaseRequestAdapter: RequestAdapter {
    
    public var request: API?
    
    public init(request: API) {
        self.request = request
    }
    
    open func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        return urlRequest
    }
    
    public func setupLog(_ urlRequest: URLRequest) -> URLRequest {
        guard let request = request else { return urlRequest}
        
        var log = "    REQUEST -> \n    - URL: \(request.url()) \n    - METHOD: \(request.method) \n    - TIME: \(Date())"
        
        switch request.logLevel {
        case .parameters:
            log = "\(log) \n    - PARAMETERS: \(String(describing: request.parameters))"
        case . headers:
            log = "\(log) \n    - HEADERS: \(String(describing:urlRequest.allHTTPHeaderFields))"
        case .full:
            log = "\(log) \n    - PARAMETERS: \(String(describing: request.parameters)) \n    - HEADERS: \(String(describing:urlRequest.allHTTPHeaderFields))"
        case .none:
            log = ""
        }
        
        DDLogInfo(log)
        return urlRequest
    }
    
}
