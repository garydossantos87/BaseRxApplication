//
//  BaseViewModel.swift
//  OnionArchitecture
//
//  Created by Gary  Dos Santos on 17/08/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import RxSwift
import Action
import UserNotifications

open class BaseViewModel {
    public var wireframe = BaseWireframe()
    public var disposeBag = DisposeBag()
    public var navigationBarTitle = Variable<String?>(nil)
    public let reloadAction = CocoaAction { return .empty() }
    public let actionError: Action<BaseErrorEntity, BaseErrorEntity> = Action { element in
        return Observable.create({ observer -> Disposable in
            observer.onNext(element)
            observer.onCompleted()
            return Disposables.create()
        })
    }
    public let actionSuccess: Action<Any?, Any?> = Action { element in
        return Observable.create({ observer -> Disposable in
            observer.onNext(element)
            observer.onCompleted()
            return Disposables.create()
        })
    }
    public let showLoadingAction: Action<Visibility, Visibility> = Action { element in
        return Observable.create({ observer -> Disposable in
            observer.onNext(element)
            observer.onCompleted()
            return Disposables.create()
        })
    }
    public let showStatusBarLoadingAction: Action<Visibility, Visibility> = Action { element in
        return Observable.create({ observer -> Disposable in
            observer.onNext(element)
            observer.onCompleted()
            return Disposables.create()
        })
    }
    
    public init() {
        // This initializer intentionally left empty
        setupStaticStrings()
    }
    
    // ----------------------------
    // MARK: - Setups
    // ----------------------------
    
    open func setup(withPresenter presenter: UIViewController) {
        wireframe.presenterViewController = presenter
    }
        
    /// Override this method to setup all the static strings tha maybe in the app should change language
    open func setupStaticStrings() {
    }
    
    /// Override this method if you want to do something in the viewWillAppear of the ViewController
    open func onViewWillAppear() {
    }
    
}
