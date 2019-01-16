//
//  RxSwift+Utils.swift
//  Seat
//
//  Created by Gary  Dos Santos on 13/09/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import Alamofire
import CocoaLumberjack

extension PrimitiveSequence where TraitType == SingleTrait {
    
    /// Transform a Single to a Maybe
    /// - returns: a valid Maybe
    public func asMaybe() -> PrimitiveSequence<MaybeTrait, Element> {
        return self.asObservable().asMaybe()
    }
    
    /// Transform a Single to a Completable
    /// - returns: a valid Completable
    public func asCompletable() -> PrimitiveSequence<CompletableTrait, Never> {
        return self.asObservable().flatMap { _ in Observable<Never>.empty() }.asCompletable()
    }
    
}

extension PrimitiveSequence where TraitType == CompletableTrait, ElementType == Swift.Never {
    
    /// Transform a Completable to a Maybe
    /// - returns: a valid Maybe
    public func asMaybe() -> PrimitiveSequence<MaybeTrait, Element> {
        return self.asObservable().asMaybe()
    }
    
    /// Transform a Completable to a single with a default value
    /// - parameters:
    ///     - value: of the default Single to be created
    /// - returns: a valid Maybe
    public func toSingleDefault<T>(with value: T) -> PrimitiveSequence<SingleTrait, T> {
        return Single<T>.create { observer in
            return self.subscribe(onCompleted: {
                observer(.success(value))
            }, onError: {
                observer(.error($0))
            })
        }
    }
    
}

extension ObservableType {
    
    public func mapObject<T: Mappable>(url: URLConvertible) -> Observable<T> {
        return flatMap { data -> Observable<T> in
            guard let response = data as? BaseResponse else {
                throw NSError(
                    domain: "Empty Response",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "Empty Response"]
                )
            }
            
            DDLogInfo("    RESPONSE -> \n    - URL: \(url) \n    - STATUS CODE: \(response.httpURLResponse?.statusCode ?? 0) \n    - JSON: \(response.json ?? "")\n")
            // Return a empty Observable to avoid parse a nil object
            // If you create a Maybe object, the signal will terminate with a onCompleted event, otherwise the success event
            if let httpURLResponse = response.httpURLResponse, httpURLResponse.statusCode == Network.noContentStatus, let genericObject = Mapper<T>().map(JSON: [:]) {
                return Observable.just(genericObject)
            }
            guard let object = Mapper<T>().map(JSONObject: response.json) else {
                throw NSError(
                    domain: "ObjectMapper can't mapping",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
                )
            }
            return Observable.just(object)
        }
    }
    
    public func mapArray<T: Mappable>(url: URLConvertible) -> Observable<[T]> {
        return flatMap { data -> Observable<[T]> in
            guard let response = data as? BaseResponse else {
                throw NSError(
                    domain: "Empty Response",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "Empty Response"]
                )
            }
            DDLogInfo("    RESPONSE -> \n    - URL: \(url) \n    - STATUS CODE: \(response.httpURLResponse?.statusCode ?? 0) \n    - JSONARRAY: \(response.json ?? "")\n")
            // Return a empty Observable to avoid parse a nil object
            // If you create a Maybe object, the signal will terminate with a onCompleted event, otherwise the success event
            if let httpURLResponse = response.httpURLResponse, httpURLResponse.statusCode == Network.noContentStatus {
                return Observable.just([])
            }
            guard let object = Mapper<T>().mapArray(JSONObject: response.json) else {
                throw NSError(
                    domain: "ObjectMapper can't mapping",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
                )
            }
            return Observable.just(object)
        }
    }
    
    public func mapString(url: URLConvertible) -> Observable<String> {
        return flatMap { plainData -> Observable<String> in
            guard let data = plainData as? Data, let object = String(data: data, encoding: .utf8) else {
                throw NSError(
                    domain: "ObjectMapper can't mapping",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
                )
            }
            DDLogInfo("    RESPONSE -> \n    - URL: \(url) \n    - STRING: \(object)\n ")
            return Observable.just(object)
        }
    }
    
}
