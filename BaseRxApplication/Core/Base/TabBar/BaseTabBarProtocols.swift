//
//  BaseTabBarProtocols.swift
//  BaseRxApplication
//
//  Created by Gary Dos Santos on 28/3/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

public protocol BaseTabBarCustomDataSource {
    func tabBarItemsInCustomTabBar(_ tabBarView: BaseTabBarCustomView) -> [BaseTabBarCustomItem]
}

public protocol BaseTabBarCustomDelegate {
    func didSelectViewController(tabBarView: BaseTabBarCustomView, atIndex index: Int) -> Bool
}

public protocol BaseTabBarCustomItemDelegate {
    func animate()
}
