//
//  BaseEntityDataMapper.swift
//  BaseRxApplication
//
//  Created by Gary  Dos Santos on 05/03/2018.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import Foundation

/// Generic Base Protocol with generic date types
public protocol BaseGenericDataMapper {
    
    associatedtype InData
    associatedtype OutData
    
}

/** Base protocol with the available methods to transforms the classes
 - Important:
 To conform the protocol you need to implement the next methods:
 - func transform(entity: InData) -> OutData?
 - func transform(entityList: [InData]) -> [OutData]?
 - func inverseTransform(entity: OutData) -> InData?
 - func inverseTransform(entityList: [OutData]) -> [InData]?
 */
public protocol BaseDataMapper: BaseGenericDataMapper {
    
    /// Transform a object type InData into a object type OutData.
    /// - parameters:
    ///     - entity: Object to be transformed
    /// - returns: new OutData object
    func transform(entity: InData?) -> OutData
    
    /// Transform a object type [InData] into a object type [OutData].
    /// - parameters:
    ///     - entity: Object to be transformed
    /// - returns: new [OutData] object
    func transform(entityList: [InData]?) -> [OutData]
    
    /// Transform a object type OutData into a object type InData.
    /// - parameters:
    ///     - entity: Object to be transformed
    /// - returns: new InData object
    func inverseTransform(domain: OutData?) -> InData
    
    /// Transform a object type [OutData] into a object type [InData].
    /// - parameters:
    ///     - entity: Object to be transformed
    /// - returns: new [InData] object
    func inverseTransform(domainList: [OutData]?) -> [InData]
    
}

/** Class that implement the Protocol to transform the classes.
 - parameters:
 - T: The parameter type out for the class
 - E: The parameter type in for the class
 */
open class BaseEntityDataMapper<T,E>: BaseGenericDataMapper {
    
    public typealias InData = E
    public typealias OutData = T
    
    public init() {
    }
    
}

/** Class that implement the Protocol to transform the classes.
 - parameters:
 - T: The parameter type out for the class
 - E: The parameter type in for the class
 */
open class BaseModelDataMapper<T,E>: BaseGenericDataMapper {
    
    public typealias InData = E
    public typealias OutData = T
    
    public init() {
    }
    
}

extension BaseDataMapper {
    
    public func transform(entityList: [InData]?) -> [OutData] {
        guard let entityList = entityList else { return [] }
        
        return entityList.map { self.transform(entity: $0) }
    }
    
    public func inverseTransform(domainList: [OutData]?) -> [InData] {
        guard let domainList = domainList else { return [] }
        
        return domainList.map { self.inverseTransform(domain: $0) }
    }
    
}
