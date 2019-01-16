//
//  DialogViewModel.swift
//  BaseRxApplication
//
//  Created by Gary  Dos Santos on 11/04/2018.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import RxSwift
import Action

public enum BaseDialogBackgroundStyle { case blur, solidColor}

open class BaseDialogViewModel: BaseViewModel {
    
    var view = BehaviorSubject<UIView?>(value: nil)
    var viewController = BehaviorSubject<UIViewController?>(value: nil)
    var backgroundStyle = BehaviorSubject<(BaseDialogBackgroundStyle, UIBlurEffectStyle, UIColor)>(value: (.solidColor, .dark, UIColor.black.withAlphaComponent(0.75)))
    var canceledOnTouchOutside = Variable(true)
    public var cancelActionPop = Variable(false)
    
    // ----------------------------
    // MARK: - Setups
    // ----------------------------
    
    public func setup(withView view: UIView, withBackgroundStyle backgroundStyle: BaseDialogBackgroundStyle = .solidColor, withBlurStyle blurStyle: UIBlurEffectStyle = .dark, withBackgroundColor backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.75), canCanceledOnTouchOutside canCancel: Bool = true, cancelActionPop: Bool = false) {
        self.view.onNext(view)
        self.backgroundStyle.onNext((backgroundStyle, blurStyle, backgroundColor))
        self.canceledOnTouchOutside.value = canCancel
        self.cancelActionPop.value = cancelActionPop
    }
    
}
