//
//  ExampleGateway.swift
//  BaseRxApplicationExamples
//
//  Created by Gary Dos Santos on 5/3/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import RxSwift

protocol ExampleGateway {
    
    func requestSingleFaqs() -> Single<CopyEntity>

}
