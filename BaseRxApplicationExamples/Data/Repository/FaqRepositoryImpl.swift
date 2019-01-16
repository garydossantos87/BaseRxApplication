//
//  FaqRepositoryImpl.swift
//  BaseRxApplicationExamples
//
//  Created by Gary Dos Santos on 9/3/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

final class CopyReposirotyImpl: FaqRepository {
    
    private var restAPI = ExampleServiceGateway.shared
    
    func requestFaqs() -> Single<Faq?> {
        return restAPI.requestSingleFaqs().map { copyEntity -> Faq? in
            return Mapper<Faq>().map(JSONObject: copyEntity.toJSON())
        }
    }
    
}
