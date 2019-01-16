//
//  DialogAnimationController.swift
//  BaseRxApplication
//
//  Created by Gary Dos Santos on 6/6/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

public final class DialogAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var duration: Double = 0.0
    private var operation = UINavigationControllerOperation.none
    
    public init(operation: UINavigationControllerOperation, duration: Double) {
        super.init()
        
        self.operation = operation
        self.duration = duration
    }
    
    // ------------------------------------------------
    // MARK: - UIViewControllerTransitioningDelegate 🖼
    // ------------------------------------------------
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from), let toView = transitionContext.view(forKey: .to) else { return }
        
        let container = transitionContext.containerView
        toView.alpha = 0.0
        container.addSubview(fromView)
        container.addSubview(toView)
        UIView.animate(withDuration: duration, animations: {
            fromView.alpha = 0.0
            toView.alpha = 1.0
        }, completion: { (finished) in
            fromView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
}
