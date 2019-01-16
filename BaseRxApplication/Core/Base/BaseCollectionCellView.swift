//
//  BaseCollectionCellView.swift
//  BaseRxApplication
//
//  Created by Gary  Dos Santos on 08/03/2018.
//  Copyright © 2018. All rights reserved.
//

import UIKit
import RxSwift

open class BaseCollectionCellView<VM>: UICollectionViewCell, BaseViewDelegate {
    
    open var viewModel: VM!
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
    
    open func set(viewModel: VM) {
        self.viewModel = viewModel
        setupRx()
    }
    
    public static func register(collectionView: UICollectionView, cellClass: AnyClass) {
        let nibName = String(describing: cellClass.self)
        if !nibName.isEmpty {
            collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
        } else {
            collectionView.register(cellClass, forCellWithReuseIdentifier: nibName)
        }
    }
    
    public static var reuseIdentifier: String {
        return String(describing: self.self)
    }
    
}

