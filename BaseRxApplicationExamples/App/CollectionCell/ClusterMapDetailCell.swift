//
//  ClusterMapDetailCell.swift
//  Seat
//
//  Created by Gary Dos Santos on 12/9/17.
//  Copyright © 2017. All rights reserved.
//

import RxSwift
import RxCocoa
import BaseRxApplication

final class ClusterMapDetailCell: BaseCollectionCellView<ClusterMapDetailCellViewModel> {
    
    @IBOutlet weak var titleLabel: UILabel!
    static let preferredHeight: CGFloat = 48.0
        
    override func setupLayout() {
        super.setupLayout()
        
        titleLabel.textColor = UIColor.red
    }
    
    override func setupRx() {
        super.setupRx()
        
        viewModel.title.bind(to: titleLabel.rx.text).disposed(by: disposeBag)
    }
    
}
