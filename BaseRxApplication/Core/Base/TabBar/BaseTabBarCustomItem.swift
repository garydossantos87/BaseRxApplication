//
//  BaseTabBarCustomItem.swift
//  BaseRxApplication
//
//  Created by Gary Dos Santos on 28/3/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

open class BaseTabBarCustomItem: UIView, BaseTabBarCustomItemDelegate {
    
    private var image = UIImage()
    private var selectedImage = UIImage()
    private var iconView = UIImageView()
    
    public init(frame: CGRect, size: CGSize = .zero, edges: UIEdgeInsets = .zero) {
        super.init(frame : frame)
        
        backgroundColor = UIColor.clear
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit
        addSubview(iconView)
        if size == .zero && edges == .zero {
            iconView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            iconView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            iconView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        } else {
            iconView.heightAnchor.constraint(equalToConstant: size.height).isActive = true
            iconView.widthAnchor.constraint(equalToConstant: size.width).isActive = true
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: edges.top).isActive = true
        }
    }
    
    convenience init() {
        self.init(frame:CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(item: UITabBarItem) {
        guard let image = item.image else {
            fatalError("add images to tabbar items")
        }
        
        self.image = image
        if let selectedImage = item.selectedImage {
            self.selectedImage = selectedImage
        } else {
            self.selectedImage = image
        }
        normal()
    }
    
    // --------------------------------
    // MARK: - Control change status
    // --------------------------------
    
    open func selected() {
        iconView.image = selectedImage
        animate()
    }
    
    open func normal() {
        iconView.image = image
    }
    
    open func animate() {
        // Nothing to animate
    }
    
}
