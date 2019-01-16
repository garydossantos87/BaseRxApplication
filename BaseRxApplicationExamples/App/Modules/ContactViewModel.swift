//
//  ContactViewModel.swift
//  Seat
//
//  Created by Gary Dos Santos on 02/10/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import RxSwift
import BaseRxApplication

final class ContactViewModel: BaseViewModel {

    var headerString = BehaviorSubject(value: "write_us_your_story".localized)
    var explanation = BehaviorSubject(value: "write_us_your_issue".localized)
    
    override func onViewWillAppear() {
        _ = ExampleServiceGateway.shared.requestSingleFaqs()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .success(let copies):
                    print(copies)
                case .error(let error):
                    self.actionError.execute(error.apiError())
                }
            }.disposed(by: disposeBag)
    }
    
    //MARK: TableView values methods
    func numberOfRows() -> Int {
        return 5
    }
    
    func cellIdentifier(forIndexPath indexPath: IndexPath) -> String {
        return HeaderCell.reuseIdentifier
    }
    
    func collectionCellIdentifier(indexPath: IndexPath) -> String {
        return ClusterMapDetailCell.reuseIdentifier
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> Any {
        let viewModel = HeaderCellModel()
        viewModel.setup(title: "asd", separatorHidden: true)
        return viewModel
    }
    
    func collectionCellViewModel(forIndexPath indexPath: IndexPath) -> ClusterMapDetailCellViewModel {
        let viewModel = ClusterMapDetailCellViewModel()
        viewModel.setup(title: "asd", separatorHidden: true)
        return viewModel
    }
    
    func height(forIndexPath indexPath: IndexPath) -> CGFloat {
        return HeaderCell.preferredHeight
    }
    
    func didSelectRow(atIndexPath indexPath: IndexPath) {
    }
}


