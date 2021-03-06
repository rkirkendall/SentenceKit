//
//  BlurOverlay.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 4/6/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit

open class BlurOverlay: BaseViewController {
    
    let closeButton = UIButton(autolayout: true)
    var blurEffect = UIBlurEffect(style: .extraLight)
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        if !UIAccessibility.isReduceTransparencyEnabled {
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.frame
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(blurEffectView)
        }else {
            let transluscentView = UIVisualEffectView(effect: blurEffect)
            transluscentView.frame = view.frame
            transluscentView.layer.opacity = 0.5
            transluscentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(transluscentView)
        }
        
        closeButton.setImage(UIImage(named: "close-black"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        view.addSubview(closeButton)
    }
    
    @objc func closeTapped(){
        dismiss(animated: false)
    }

    override open func setupConstraints() {
        super.setupConstraints()
        let views = ["close": closeButton]
        var layoutConstraints = [NSLayoutConstraint]()
        layoutConstraints += "V:|-[close(40)]".constraints(views: views)
        layoutConstraints += "H:|-[close(40)]".constraints(views: views)
        view.addConstraints(layoutConstraints)
    }
    
}

public protocol ControlFragmentEditControllerDelegate: class {
    func editController(_ editController: EditBaseController, didReturnWithValue value: String)
}

open class EditBaseController: BlurOverlay {
    var style: SentenceStyle?
    weak var delegate: ControlFragmentEditControllerDelegate?
}
#endif
