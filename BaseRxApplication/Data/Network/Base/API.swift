//
//  API.swift
//  BaseRxApplication
//
//  Created by Gary Dos Santos on 5/3/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

public enum EncodeType { case json, array, form }

public enum LogLevel { case parameters, headers, full, none }

public protocol API {
    
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String : Any]? { get }
    var headers: [String : String]? { get }
    var encodeType: EncodeType { get }
    var adapter: BaseRequestAdapter? { get }
    var oauth: Bool { get }
    var error: BaseErrorEntity { get }
    var logLevel: LogLevel { get }
    
}

public protocol MappableError {
    
    func error() -> NSError
    
}

extension API {
    
    public func url() -> URLConvertible {
        return baseUrl + path
    }
    
    public func encoding() -> ParameterEncoding {
        switch encodeType {
        case .json:
            return JSONEncoding.default
        case .array:
            return ArrayEncoding.default
        case .form:
            return URLEncoding.default
        }
    }
    
}
