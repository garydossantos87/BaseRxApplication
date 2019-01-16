//
//  ExampleAPI.swift
//  BaseRxApplicationExamples
//
//  Created by Gary Dos Santos on 5/3/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import Alamofire
import BaseRxApplication
import ObjectMapper

enum ExampleAPI{
    
    case faqs
    case login(String, String)
    case gary(BaseEntity)
    case user(BaseEntity)
    
}

extension ExampleAPI: API {
    
    var baseUrl: String {
        return "http://demo0887010.mockable.io/"
    }
    
    var path: String {
        switch self {
        case .faqs:
            return "faqs"
        case .login:
            return "login"
        case .gary:
            return "gary"
        default:
            return ""
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var encodeType: EncodeType {
        switch self {
        case .faqs:
            return .json
        case .gary:
            return .form
        default:
            return .json
        }
    }
    
    var oauth: Bool {
        return true
    }
    
    var adapter: RequestAdapter? {
        return NetworkHeadersAdapter(request: self)
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .login(let user, let password):
            return ["user": user, "password" : password]
        case .gary(let base), .user(let base):
            return base.toJSON()
        default:
            return nil
        }
    }
    
    var error: BaseErrorEntity {
        return ErrorEntity()
    }
    
}
