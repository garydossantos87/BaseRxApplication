//
//  GetFaqsUseCase.swift
//  BaseRxApplicationExamples
//
//  Created by Gary Dos Santos on 9/3/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import RxSwift

protocol GetFaqsUseCase {
    
    func execute() -> Single<Faq?>
    
}
