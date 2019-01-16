//
//  CartTabBarCustomItem.swift
//  BaseRxApplicationExamples
//
//  Created by Gary Dos Santos on 28/3/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit
import BaseRxApplication

class CartTabBarCustomItem: BaseTabBarCustomItem {
    
    private let quantityLabel = UILabel()
    private var topConstraint = NSLayoutConstraint()
    var quantity = 0 {
        didSet {
            quantityLabel.isHidden = quantity == 0
            quantityLabel.text = "\(quantity)"
            animateProduct()
        }
    }
    
    override init(frame: CGRect, size: CGSize = .zero, edges: UIEdgeInsets = .zero) {
        super.init(frame: frame, size: size, edges: edges)
        
        quantityLabel.font = UIFont.systemFont(ofSize: 9.0)
        quantityLabel.textAlignment = .center
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.isUserInteractionEnabled = false
        quantityLabel.backgroundColor = UIColor.red
        addSubview(quantityLabel)
        
        topConstraint = quantityLabel.topAnchor.constraint(equalTo: topAnchor)
        let constaints = [topConstraint, quantityLabel.leadingAnchor.constraint(equalTo: leadingAnchor), quantityLabel.trailingAnchor.constraint(equalTo: trailingAnchor)]
        addConstraints(constaints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func selected() {
        super.selected()
    }
    
    override func animate() {
        
    }
    
    // -----------------------------
    // MARK: - Animation when needed
    // -----------------------------
    
    private func animateProduct() {
        topConstraint.constant = 0.0
        layoutIfNeeded()
        topConstraint.constant = 10.0
        UIView.animate(withDuration: 1.0, animations: {
            self.layoutIfNeeded()
        })
    }
    
}
