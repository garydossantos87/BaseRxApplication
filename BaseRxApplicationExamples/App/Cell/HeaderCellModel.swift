//
//  HeaderCellModel.swift
//  Seat
//
//  Created by Gary Dos Santos on 13/09/2017.
//  Copyright © 2017. All rights reserved.
//

import RxSwift

final class HeaderCellModel {
    
    var title = BehaviorSubject(value: "")
    var separatorHidden = BehaviorSubject(value: true)
    
    func setup(title: String, separatorHidden: Bool) {
        self.title.onNext(title)
        self.separatorHidden.onNext(separatorHidden)
    }
    
}
