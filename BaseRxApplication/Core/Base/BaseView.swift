//
//  BaseView.swift
//  BaseRxApplication
//
//  Created by Gary  Dos Santos on 05/03/2018.
//  Copyright © 2018. All rights reserved.
//

import UIKit
import RxSwift

open class BaseView: UIView, BaseViewDelegate {
    
    @IBOutlet weak var view: UIView!
    
    public var disposeBag = DisposeBag()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        nibSetup()
        setupLayout()
        setupRx()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
        nibSetup()
        setupLayout()
        setupRx()
    }
    
    private func nibSetup() {
        backgroundColor = UIColor.clear
        
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        return nibView ?? UIView(frame: .zero)
    }
    
    open func setupLayout() {
        // override this function to setup the layout view
    }
    
    open func setupRx() {
        disposeBag = DisposeBag()
    }
        
}
