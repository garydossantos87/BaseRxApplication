//
//  UIStackView+Utils.swift
//  BaseRxApplication
//
//  Created by Gary Dos Santos on 9/4/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

extension UIStackView {
    
    public func removeAll() {
        arrangedSubviews.forEach { view in
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    public func removeAll<T: UIView>(type: T.Type) {
        arrangedSubviews.filter({ $0 is T }).forEach { view in
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
}
