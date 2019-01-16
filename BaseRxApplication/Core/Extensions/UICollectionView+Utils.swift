//
//  UICollectionView+Utils.swift
//  BaseRxApplication
//
//  Created by Gary  Dos Santos on 08/03/2018.
//  Copyright © 2018. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    public func dequeueReusableBaseCell<T>(withReuseIdentifier identifier: String, for indexPath: IndexPath, viewModel: Any) -> BaseCollectionCellView<T> {
        if let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? BaseCollectionCellView<T>, let model = viewModel as? T {
            cell.set(viewModel: model)
            return cell
        }
        return BaseCollectionCellView<T>()
    }
    
}

