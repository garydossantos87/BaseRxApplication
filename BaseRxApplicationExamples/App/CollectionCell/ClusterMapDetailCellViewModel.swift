//
//  ClusterMapDetailCellViewModel.swift
//  Seat
//
//  Created by Gary Dos Santos on 12/9/17.
//  Copyright © 2017. All rights reserved.
//

import RxSwift
import Action

final class ClusterMapDetailCellViewModel {
    
    var title = BehaviorSubject(value: "")
    var separatorHidden = BehaviorSubject(value: true)
    
    func setup(title: String, separatorHidden: Bool) {
        self.title.onNext(title)
        self.separatorHidden.onNext(separatorHidden)
    }
    
}

