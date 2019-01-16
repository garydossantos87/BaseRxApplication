//
//  NetworkProxy.swift
//  BaseRxApplication
//
//  Created by Gary Dos Santos on 6/3/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

open class NetworkProxy {
    
    open var configuration: URLSessionConfiguration {
        return URLSessionConfiguration.default
    }
    
    public init() { }
    
    /// JSON
    
    /// Process a server call and parse the response as a JSON object
    ///    - Important:
    ///         - Use it if you want to get a single object response "only one"
    ///         - If you use a flatmap or map the autocomplete will return a PrimitiveSecuence<T> and you will get errors change it with Single<T> and that's all :D
    /// - parameters:
    ///     - type: use it to parse the object into the type of object that you want
    ///     - networkService: the configuration to call the API
    /// - returns: a Single<T> object with the response
    public func process<T: Mappable>(networkService: API) -> Single<T> {
        return Network(configuration: configuration).request(request: networkService).asSingle()
    }
    
    /// Process a server call and parse the response as a JSON object
    ///    - Important:
    ///         Use it if you want to get a maybe object response "only one"
    /// - parameters:
    ///     - type: use it to parse the object into the type of object that you want
    ///     - networkService: the configuration to call the API
    /// - returns: a Maybe<T> object with the response
    public func process<T: Mappable>(networkService: API) -> Maybe<T> {
        return Network(configuration: configuration).request(request: networkService).asMaybe()
    }
    
    /// Process a server call and parse the response as a JSON object
    ///    - Important:
    ///         Use it if you want to get N objects response "multiples"
    /// - parameters:
    ///     - type: use it to parse the object into the type of object that you want
    ///     - networkService: the configuration to call the API
    /// - returns: a Observable<T> object with the response
    public func process<T: Mappable>(networkService: API) -> Observable<T> {
        return Network(configuration: configuration).request(request: networkService)
    }
    
    /// Process a server call and parse the response as a JSON object
    ///    - Important:
    ///         Use it if you want to get a success response without value only the success/error response
    /// - parameters:
    ///     - type: use it to parse the object into the type of object that you want
    ///     - networkService: the configuration to call the API
    /// - returns: a Completable object with the response
    public func process(networkService: API) -> Completable {
        let single: Single<BaseEntity> = Network(configuration: configuration).request(request: networkService).asSingle()
        return single.asCompletable()
    }
    
    /// ARRAY
    
    /// Process a server call and parse the response as a Array object
    /// Process a server call and parse the response as a Array object
    ///    - Important:
    ///         - Use it if you want to get a single object response "only one"
    ///         - If you use a flatmap or map the autocomplete will return a PrimitiveSecuence<T> and you will get errors change it with Single<T> and that's all :D
    /// - parameters:
    ///     - type: use it to parse the object into the type of object that you want
    ///     - networkService: the configuration to call the API
    /// - returns: a Single<T> object with the response
    public func processArray<T: Mappable>(networkService: API) -> Single<[T]> {
        return Network(configuration: configuration).requestArray(request: networkService).asSingle()
    }
    
    /// Process a server call and parse the response as a Array object
    ///    - Important:
    ///         Use it if you want to get a single object response "only one"
    /// - parameters:
    ///     - type: use it to parse the object into the type of object that you want
    ///     - networkService: the configuration to call the API
    /// - returns: a Maybe<T> object with the response
    public func processArray<T: Mappable>(networkService: API) -> Maybe<[T]> {
        return Network(configuration: configuration).requestArray(request: networkService).asMaybe()
    }
    
    /// Process a server call and parse the response as a Array object
    ///    - Important:
    ///         Use it if you want to get N objects response "multiples"
    /// - parameters:
    ///     - type: use it to parse the object into the type of object that you want
    ///     - networkService: the configuration to call the API
    /// - returns: a Observable<T> object with the response
    public func processArray<T: BaseEntity>(networkService: API) -> Observable<[T]> {
        return Network(configuration: configuration).requestArray(request: networkService)
    }
    
    /// Process a server call and parse the response as a Array object
    ///    - Important:
    ///         Use it if you want to get a success response without value only the success/error response
    /// - parameters:
    ///     - type: use it to parse the object into the type of object that you want
    ///     - networkService: the configuration to call the API
    /// - returns: a Completable object with the response
    public func processArray(networkService: API) -> Completable {
        let single: Single<[BaseEntity]> = Network(configuration: configuration).requestArray(request: networkService).asSingle()
        return single.asCompletable()
    }
    
    /// String
    
    /// Process a server call and parse the response as a String object
    ///    - Important:
    ///         Use it if you want to get N objects response "multiples"
    /// - parameters:
    ///     - type: use it to parse the object into the type of object that you want
    ///     - networkService: the configuration to call the API
    /// - returns: a Observable<T> object with the response
    public func processString(networkService: API) -> Observable<String> {
        return Network(configuration: configuration).requestString(request: networkService)
    }
    
    /// Process a server call and parse the response as a String object
    ///    - Important:
    ///         - Use it if you want to get a single object response "only one"
    ///         - If you use a flatmap or map the autocomplete will return a PrimitiveSecuence<T> and you will get errors change it with Single<T> and that's all :D
    /// - parameters:
    ///     - type: use it to parse the object into the type of object that you want
    ///     - networkService: the configuration to call the API
    /// - returns: a Single<T> object with the response
    public func processString(networkService: API) -> Single<String> {
        return Network(configuration: configuration).requestString(request: networkService).asSingle()
    }
    
    /// Process a server call and parse the response as a String object
    ///    - Important:
    ///         Use it if you want to get a single object response "only one"
    /// - parameters:
    ///     - type: use it to parse the object into the type of object that you want
    ///     - networkService: the configuration to call the API
    /// - returns: a Maybe<T> object with the response
    public func processString(networkService: API) -> Maybe<String> {
        return Network(configuration: configuration).requestString(request: networkService).asSingle().asMaybe()
    }
    
    /// Process a server call and parse the response as a String object
    ///    - Important:
    ///         Use it if you want to get a success response without value only the success/error response
    /// - parameters:
    ///     - type: use it to parse the object into the type of object that you want
    ///     - networkService: the configuration to call the API
    /// - returns: a Completable object with the response
    public func processString(networkService: API) -> Completable {
        return Network(configuration: configuration).requestString(request: networkService).asSingle().asCompletable()
    }
    
    /// Process a server call and parse the response as a Data object
    ///    - Important:
    ///         Use it if you want to get a success response without value only the success/error response
    /// - parameters:
    ///     - networkService: the configuration to call the API
    /// - returns: a <T> object with the response
    public func processData(networkService: API) -> Single<Data> {
        return Network(configuration: configuration).requestServerData(request: networkService).asSingle()
    }
    
}
