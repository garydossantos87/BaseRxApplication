//
//  DialogViewController.swift
//  BaseRxApplication
//
//  Created by Gary Dos Santos on 11/04/2018.
//  Copyright © 2018. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

open class BaseDialogViewController<VM: BaseDialogViewModel>: BaseViewController<VM>, UINavigationControllerDelegate {
    
    private let containerView = UIView()
    private let centerPriority: Int = 750
    private let backgroundView = UIView()
    open var durationAnimation: Double {
        return 1.0
    }
    open var percentageOfContainerSize: CGFloat {
        return 0.9
    }
    
    open var percentageGreaterOfContainerSize: CGFloat {
        return 0.0
    }
    
    public override init() {
        super.init()
        
        modalPresentationStyle = .overCurrentContext
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDialogWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDialogWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        view.endEditing(true)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // ----------------------------
    // MARK: - Setups
    // ----------------------------
    
    override open func setupLayout() {
        super.setupLayout()
        
        view.isOpaque = false
        view.backgroundColor = UIColor.clear
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { maker in
            maker.edges.equalTo(self.view)
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onCloseViewPushed(_:)))
        backgroundView.addGestureRecognizer(tapGesture)
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { maker in
            maker.center.equalTo(self.view).priority(centerPriority)
            maker.width.greaterThanOrEqualTo(self.view).multipliedBy(percentageGreaterOfContainerSize)
            maker.width.lessThanOrEqualTo(self.view).multipliedBy(percentageOfContainerSize)
            maker.height.lessThanOrEqualTo(self.view).multipliedBy(percentageOfContainerSize)
        }
    }
    
    override open func setupRx() {
        super.setupRx()
        
        viewModel.backgroundStyle.subscribe(onNext: { [weak self] (dialogStyle, blurStyle, color) in
            guard let `self` = self else { return }
            
            if dialogStyle == .blur {
                self.backgroundView.blur(withBlurStyle: blurStyle)
            } else {
                self.backgroundView.backgroundColor = color
            }
        }).disposed(by: disposeBag)
        
        viewModel.view.subscribe(onNext: { [weak self] view in
            guard let `self` = self, let customView = view else { return }
            
            self.containerView.addSubview(customView)
            customView.snp.makeConstraints { maker in
                maker.edges.equalTo(self.containerView)
            }
        }).disposed(by: disposeBag)
        
        viewModel.viewController.subscribe(onNext: { [weak self] viewController in
            guard let `self` = self, let viewController = viewController else { return }
            
            self.addChildViewController(withViewController: viewController, withContainerView: self.containerView)
        }).disposed(by: disposeBag)
    }
    
    // ----------------------------
    // MARK: - Actions 👇
    // ----------------------------
    
    @objc func onCloseViewPushed(_ recognizer: UITapGestureRecognizer)  {
        if viewModel.canceledOnTouchOutside.value {
            if viewModel.cancelActionPop.value {
                navigationController?.popViewController(animated: true)
            } else {
                dismiss(animated: true, completion: nil)
            }
        } else {
            view.endEditing(true)
        }
    }
    
    // ---------------------------------
    // MARK: - Control position keyboard
    // ---------------------------------
    
    @objc private func keyboardDialogWillShow(_ notification: NSNotification) {
        adjustDialogForKeyboardShow(show: true, notification: notification)
    }
    
    @objc private func keyboardDialogWillHide(_ notification: NSNotification) {
        adjustDialogForKeyboardShow(show: false, notification: notification)
    }
    
    private func adjustDialogForKeyboardShow(show: Bool, notification: NSNotification) {
        guard let value = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardFrame = value.cgRectValue
        containerView.snp.remakeConstraints { maker in
            if keyboardFrame.height > 0.0 && show {
                maker.centerX.equalTo(view)
                maker.centerY.equalTo(view).offset(-(keyboardFrame.height / 2.0))
            } else {
                maker.center.equalTo(view).priority(centerPriority)
            }
            maker.width.lessThanOrEqualTo(view).multipliedBy(percentageOfContainerSize)
            maker.height.lessThanOrEqualTo(view).multipliedBy(percentageOfContainerSize)
        }
    }
    
    // -----------------------------------------
    // MARK: - UINavigationControllerDelegate 🖼
    // -----------------------------------------
    
    @objc public func hideBackgroundView() {
        backgroundView.isHidden = true
    }
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return DialogAnimationController(operation: operation, duration: durationAnimation)
    }
    
}
