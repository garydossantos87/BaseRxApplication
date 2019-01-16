//
//  ExampleService.swift
//  BaseRxApplicationExamples
//
//  Created by Gary Dos Santos on 6/3/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import BaseRxApplication
import RxSwift

final class ExampleService: NetworkProxy {
    
    func requestFaqs() -> Single<[CopyEntity]> {
        return processArray(networkService: ExampleAPI.faqs)
    }
    
    func requestSingleFaqs() -> Single<CopyEntity> {
        return process(networkService: ExampleAPI.faqs)
    }
    
}
