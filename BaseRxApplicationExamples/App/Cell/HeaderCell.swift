//
//  HeaderCell.swift
//  Seat
//
//  Created by Gary Dos Santos on 13/09/2017.
//  Copyright © 2017. All rights reserved.
//

import UIKit
import RxSwift
import BaseRxApplication

final class HeaderCell: BaseCellView<HeaderCellModel> {
    
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    static let preferredHeight: CGFloat = 48.0
        
    override func setupLayout() {
        super.setupLayout()
    }
    
    override func setupRx() {
        super.setupRx()
        
        viewModel.title.bind(to: titleLabel.rx.text).disposed(by: disposeBag)
        viewModel.separatorHidden.bind(to: separatorView.rx.isHidden).disposed(by: disposeBag)
    }
    
    func hideSeparatorView(hide: Bool) {
        separatorView.isHidden = hide
    }
    
}
