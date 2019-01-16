//
//  Network.swift
//  BaseRxApplication
//
//  Created by Gary Dos Santos on 5/3/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import ObjectMapper
import RxAlamofire
import CocoaLumberjack

final class Network {
    
    static let statusCodeMinError = 300
    static let noContentStatus = 204
    private var manager = SessionManager()
    
    init(configuration: URLSessionConfiguration) {
        self.manager = SessionManager(configuration: configuration)
    }
    
    public func request<T: Mappable>(request: API) -> Observable<T> {
        manager.adapter = request.adapter
        
        let observable: Observable<T> = manager.rx.responseJSON(request.method, request.url(), parameters: request.parameters, encoding: request.encoding())
            .map { response, data -> Any? in
                guard response.statusCode >= Network.statusCodeMinError else { return BaseResponse(httpURLResponse: response, json: data) }
                
                try self.showError(response: response, data: data, mappable: request.error)
                return nil
            }
            .mapObject(url: request.url())
        return observable
    }
    
    public func requestArray<T: Mappable>(request: API) -> Observable<[T]> {
        manager.adapter = request.adapter
        
        let array: Observable<[T]> = manager.rx.responseJSON(request.method, request.url(), parameters: request.parameters, encoding: request.encoding())
            .map { response, data -> Any? in
                guard response.statusCode >= Network.statusCodeMinError else { return BaseResponse(httpURLResponse: response, json: data) }
                
                try self.showError(response: response, data: data, mappable: request.error)
                return nil
            }
            .mapArray(url: request.url())
        return array
    }
    
    public func requestString(request: API) -> Observable<String> {
        manager.adapter = request.adapter

        let string: Observable<String> = manager.rx.responseData(request.method, request.url(), parameters: request.parameters, encoding: request.encoding())
            .map { response, data -> Data? in
                guard response.statusCode >= Network.statusCodeMinError, let object = String(data: data, encoding: String.Encoding.utf8), let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return data }

                try self.showError(response: response, data: json, mappable: request.error)
                return nil
            }
            .mapString(url: request.url())
        return string
    }

    func requestServerData(request: API) -> Observable<Data> {
        manager.adapter = request.adapter

        return manager.rx.responseData(request.method, request.url(), parameters: request.parameters, encoding: request.encoding())
            .map { response, data -> Data in
                guard response.statusCode >= Network.statusCodeMinError else { return data }

                try self.showError(response: response, data: data, mappable: request.error)
                return Data()
        }
    }
    
    private func showError(response: HTTPURLResponse, data: Any?, mappable: BaseErrorEntity) throws {
        guard let data = data, let JSON = data as? [String: Any] else { return }
        
        mappable.mapping(map: Map(mappingType: MappingType.fromJSON, JSON: JSON))
        DDLogError("  - URL: \(response.url?.absoluteString ?? "")\n   - STATUSCODE: \(response.statusCode) \n   - RESPONSE: \(data) ")
        throw mappable
    }

}
