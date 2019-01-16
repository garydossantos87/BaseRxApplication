//
//  ExampleTabBarController.swift
//  BaseRxApplicationExamples
//
//  Created by Gary Dos Santos on 4/4/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit
import BaseRxApplication

class ExampleTabBarController: BaseTabBarController {
    
    private var cartCustomItem: CartTabBarCustomItem?
    var quantity = 0
    
    override func tabBarItemsInCustomTabBar(_ tabBarView: BaseTabBarCustomView) -> [BaseTabBarCustomItem] {
        var tabBarCustomItems: [BaseTabBarCustomItem] = []
        
        tabBar.items?.forEach({ tabBarItem in
            let customTabBarItem = tabBarItem.title == "Cart" ? CartTabBarCustomItem(frame: CGRect.zero) : BaseTabBarCustomItem(frame: CGRect.zero)
            customTabBarItem.setup(item: tabBarItem)
            tabBarCustomItems.append(customTabBarItem)
        })
        
        cartCustomItem = tabBarCustomItems.filter{ $0 is CartTabBarCustomItem }.first as? CartTabBarCustomItem
        
        return tabBarCustomItems
    }
    
    @objc func addProduct() {
        if let cartCustomItem = cartCustomItem {
            cartCustomItem.quantity += 1
        }
    }
    
}
