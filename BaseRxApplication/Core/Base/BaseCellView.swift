//
//  BaseCellView.swift
//  BaseRxApplication
//
//  Created by Gary  Dos Santos on 05/03/2018.
//  Copyright © 2018. All rights reserved.
//

import UIKit
import RxSwift

open class BaseCellView: UITableViewCell, BaseViewDelegate {
    
    open var disposeBag = DisposeBag()
        
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLayout()
    }
    
    open func setupLayout() {
         // override this function to setup the layout view
    }
    
    open func setupRx() {
        disposeBag = DisposeBag()
    }
    
    open func set(viewModel: BaseCellViewModel) {
        
    }
    
    public static func register(tableView: UITableView, cellClass: AnyClass) {
        let nibName = String(describing: cellClass.self)
        if !nibName.isEmpty {
            tableView.register(UINib.init(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        } else {
            tableView.register(cellClass, forCellReuseIdentifier: nibName)
        }
    }
    
    public static var reuseIdentifier: String {
        return String(describing: self.self)
    }
    
}
