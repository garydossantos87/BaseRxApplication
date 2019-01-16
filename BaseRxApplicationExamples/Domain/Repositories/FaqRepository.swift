//
//  FaqRepository.swift
//  BaseRxApplicationExamples
//
//  Created by Gary Dos Santos on 9/3/18.
//  Copyright © 2018. All rights reserved.
//

import RxSwift

protocol FaqRepository {
    
    func requestFaqs() -> Single<Faq?>
    
}
