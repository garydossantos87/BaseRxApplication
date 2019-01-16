//
//  BaseViewController.swift
//  Seat
//
//  Created by Gary  Dos Santos on 06/09/2017.
//  Copyright © 2017. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import TTGSnackbar
import CocoaLumberjack

open class BaseViewController<VM: BaseViewModel>: UIViewController {
    
    private var networkReachabilityManager = NetworkReachabilityManager()
    open var viewModel: VM!
    open var scrollView: UIScrollView!
    open var disposeBag = DisposeBag()
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(TranslatorManager.settingsLanguageDidChangeNotifications), object: nil)
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        viewModel = createViewModel()
        checkNetworkStatus()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ---------------------------------
    // MARK: - Open Func to OVERRIDE
    // ---------------------------------
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupLayout()
        setupRx()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.onViewWillAppear()
        navigationController?.setNavigationBarHidden(viewModel.navigationBarTitle.value == nil, animated: true)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeLanguage(_:)), name: NSNotification.Name(TranslatorManager.settingsLanguageDidChangeNotifications), object: nil)
        
        if scrollView != nil {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if scrollView != nil {
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
    }
    
    /// Override and return a presenter in a subclass.
    open func createViewModel() -> VM {
        DDLogError("  VMMV method `createViewModel()` must be override in a subclass and do not call `super.createViewModel()`!")
        preconditionFailure("VMMV method `createViewModel()` must be override in a subclass and do not call `super.createViewModel()`!")
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    open func setupRx() {
        disposeBag = DisposeBag()
        
        viewModel.actionError.inputs.subscribe(onNext: { [weak self] error in
            guard let `self` = self else { return }
            
            self.manageActionError(error: error)
        }).disposed(by: disposeBag)
        
        viewModel.showLoadingAction.inputs.subscribe(onNext: { [weak self] visibility in
            guard let `self` = self else { return }
            
            self.showLoading(visibility: visibility)
        }).disposed(by: disposeBag)
        
        viewModel.showStatusBarLoadingAction.inputs.subscribe(onNext: { [weak self] visibility in
            guard let `self` = self else { return }
            
            self.progressStatusBarVisibility(visibility: visibility)
        }).disposed(by: disposeBag)
        
        viewModel.navigationBarTitle.asObservable().subscribe(onNext: { [weak self] title in
            guard let `self` = self else { return }
            
            self.title = title ?? ""
            self.navigationController?.setNavigationBarHidden(title == nil, animated: true)
        }).disposed(by: disposeBag)
    }
    
    open func setupLayout() {
        edgesForExtendedLayout = .bottom
    }
    
    open func showLoading(visibility: Visibility) {
        self.progressVisibility(visibility: visibility)
    }
    
    open func manageActionError(error: BaseErrorEntity, notNetworkAvailableAction: UIAlertAction? = nil) {
        if self.isNetworkAvailable() {
            self.showAlert(error: error)
        } else {
            self.showAlertController(title: "unexpected_error_title".localized, message: "unexpected_timeout_message".localized, buttonTitle: "")
        }
    }
    
    // ----------------------------
    // MARK: - Private Func 🔐
    // ----------------------------
    
    private func adjustInsetForKeyboardShow(show: Bool, notification: NSNotification) {
        guard let value = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue, let scrollView = scrollView else { return }
        
        let keyboardFrame = value.cgRectValue
        let adjustmentHeight = keyboardFrame.height + 20.0
        scrollView.contentInset.bottom = show ? adjustmentHeight : 0.0
        scrollView.scrollIndicatorInsets.bottom = show ? adjustmentHeight : 0.0
        scrollView.layoutSubviews()
    }
    
    private func resetTitle() {
        title = ""
    }
    
    @objc private func didChangeLanguage(_ notification: NSNotification) {
        viewModel.setupStaticStrings()
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        adjustInsetForKeyboardShow(show: true, notification: notification)
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        adjustInsetForKeyboardShow(show: false, notification: notification)
    }
    
    private func checkNetworkStatus() {
        networkReachabilityManager?.startListening()
        networkReachabilityManager?.listener = { status in
            switch status {
            case .notReachable, .unknown:
                self.showSnackBar(withMessage: "network_unavailable".localized)
                DDLogError("  \n**ERROR CONNECTION -> \("network_unavailable".localized)\n")
            default: break
            }
        }
    }
    
    // ---------------------
    // MARK: - Public Func
    // ---------------------
    
    public func isNetworkAvailable() -> Bool {
        if let networkReachabilityManager = networkReachabilityManager {
            return networkReachabilityManager.isReachable
        }
        return true
    }
    
    public func setupViewModel() {
        viewModel.setup(withPresenter: self)
    }
    
    public func setupStatusBar(style: UIStatusBarStyle) {
        UIApplication.shared.statusBarStyle = style
    }
    
}
