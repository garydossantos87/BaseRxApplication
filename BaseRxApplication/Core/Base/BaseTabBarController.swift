//
//  BaseTabBarController.swift
//  BaseRxApplication
//
//  Created by Gary Dos Santos on 28/3/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

open class BaseTabBarController: UITabBarController, BaseTabBarCustomDelegate, BaseTabBarCustomDataSource {

    private var barHeight: CGFloat?
    private var transitionView: UIView?
    private var backgroundColor: UIColor?
    public let customTabBar = BaseTabBarCustomView(frame: CGRect.zero)
    public var edges = UIEdgeInsets.zero
    public var size = CGSize.zero
    public var fullScreen = false
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public convenience init(height: CGFloat, backgroundColor: UIColor = .clear, sizeItem: CGSize = .zero, edgesItem: UIEdgeInsets = .zero, fullScreen: Bool = false) {
        self.init()
        
        setupTabBar(height: height, backgroundColor: backgroundColor, sizeItem: sizeItem, edgesItem: edgesItem)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isHidden = true
        transitionView = view.subviews.filter({ !($0 is UITabBar) }).first
        view.addSubview(customTabBar)
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            customTabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor).isActive = true
        }
        customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor).isActive = true
        customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor).isActive = true
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if customTabBar.isHidden {
            self.hideTabBar()
        } else {
            self.showTabBar()
        }
    }
    
    open func showTabBar() {
        guard let height = barHeight else { return }

        if let windows = UIApplication.shared.keyWindow {
            var frame = self.view.frame
            if #available(iOS 11.0, *) {
                frame.size.height = frame.size.height - (fullScreen ? 0.0 : height) - windows.safeAreaInsets.bottom
            } else {
                frame.size.height = frame.size.height - (fullScreen ? 0.0 : height)
            }
            transitionView?.frame = frame
        }
        customTabBar.isHidden = false
        self.view.backgroundColor = backgroundColor
    }
    
    open func hideTabBar() {
        if let windows = UIApplication.shared.keyWindow {
            var frame = self.view.frame
            if #available(iOS 11.0, *) {
                frame.size.height = frame.size.height - windows.safeAreaInsets.bottom
            } else {
                frame.size.height = frame.size.height
            }
            transitionView?.frame = frame
        }
        customTabBar.isHidden = true
        self.view.backgroundColor = .white
    }
    
    override open func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        
        customTabBar.datasource = self
        customTabBar.delegate = self
        customTabBar.setup()
    }

    public func setupTabBar(height: CGFloat, backgroundColor: UIColor? = .clear, sizeItem: CGSize = .zero, edgesItem: UIEdgeInsets = .zero) {
        barHeight = height
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        customTabBar.backgroundColor = backgroundColor
        customTabBar.heightAnchor.constraint(equalToConstant: height).isActive = true
        edges = edgesItem
        size = sizeItem
    }
    
    // ------------------------------
    // MARK: - CustomTabBarDataSource
    // ------------------------------
    
    open func tabBarItemsInCustomTabBar(_ tabBarView: BaseTabBarCustomView) -> [BaseTabBarCustomItem] {
        var tabBarCustomItems: [BaseTabBarCustomItem] = []
        
        tabBar.items?.forEach({ tabBarItem in
            let customTabBarItem = BaseTabBarCustomItem(frame: CGRect.zero, size: size, edges: edges)
            customTabBarItem.setup(item: tabBarItem)
            tabBarCustomItems.append(customTabBarItem)
        })
        
        return tabBarCustomItems
    }
    
    // ----------------------------
    // MARK: - CustomTabBarDelegate
    // ----------------------------
    
    open func didSelectViewController(tabBarView: BaseTabBarCustomView, atIndex index: Int) -> Bool {
        self.selectedIndex = index
        return true
    }

}
