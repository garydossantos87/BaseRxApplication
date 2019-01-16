//
//  BaseTabBarCustomView.swift
//  BaseRxApplication
//
//  Created by Gary Dos Santos on 28/3/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

open class BaseTabBarCustomView: UIView {
    
    public var datasource: BaseTabBarCustomDataSource!
    public var delegate: BaseTabBarCustomDelegate!
    
    public var customTabBarItems: [BaseTabBarCustomItem] = []
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        let stackView = UIStackView(arrangedSubviews: createTabBarItem())
        stackView.backgroundColor = UIColor.clear
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    open func createTabBarItem() -> [UIView] {
        createTabBarTapDelegates()
        customTabBarItems.first?.selected()
        return customTabBarItems.map({ return $0 as UIView })
    }
    
    public func goToItem(_ index: Int) {
        guard index < customTabBarItems.count else { return }
        
        let sender = customTabBarItems[index]
        if delegate.didSelectViewController(tabBarView: self, atIndex: index) {
            customTabBarItems.forEach { $0.normal() }
            sender.selected()
        }
    }
    
    @objc open func barItemTapped(_ sender : UITapGestureRecognizer) {
        if let sender = sender.view as? BaseTabBarCustomItem, let index = customTabBarItems.index(of: sender) {
            if delegate.didSelectViewController(tabBarView: self, atIndex: index) {
                customTabBarItems.forEach { $0.normal() }
                sender.selected()
            }
        }
    }
    
}

// --------------------------------
// MARK: - Extension default obtain
// --------------------------------

public extension BaseTabBarCustomView {
    
    private func createTabBarTapDelegates() {
        customTabBarItems = []
        for customTabBarItem in datasource.tabBarItemsInCustomTabBar(self) {
            let tap = UITapGestureRecognizer(target: self, action: #selector(barItemTapped(_:)))
            customTabBarItem.addGestureRecognizer(tap)
            customTabBarItems.append(customTabBarItem)
        }
    }
    
}

