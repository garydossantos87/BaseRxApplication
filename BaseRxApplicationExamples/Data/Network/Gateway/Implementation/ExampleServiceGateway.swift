//
//  ExampleServiceGateway.swift
//  Seat
//
//  Created by Gary  Dos Santos on 10/10/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import RxSwift
import BaseRxApplication

final class ExampleServiceGateway: ExampleGateway {
    
    static let shared = ExampleServiceGateway()
    private var appService = ExampleService()
    
    private init() {}
    
    func requestSingleFaqs() -> Single<CopyEntity> {
        return appService.requestSingleFaqs()
    }
    
    func requestFaqs() -> Single<[CopyEntity]> {
        return appService.requestFaqs()
    }
    
}

