//
//  BlurOverlay.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 4/6/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import Modernistik

class BlurOverlay: ModernView {
    
    let closeButton = UIButton(autolayout: true)
    var blurEffect = UIBlurEffect(style: .extraLight)
    override func setupView() {
        super.setupView()
        
        closeButton.setImage(UIImage(named: "close-white"), for: .normal)
        addSubview(closeButton)
        
        if !UIAccessibility.isReduceTransparencyEnabled {
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = frame
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(blurEffectView)
        }else {
            let transluscentView = UIVisualEffectView(effect: blurEffect)
            transluscentView.frame = frame
            transluscentView.layer.opacity = 0.5
            transluscentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(transluscentView)
        }
    }
    
    func dismiss(animate: Bool) {
        fadeOut {
            self.isHidden = true
        }
    }
    
    func show(animate: Bool) {
        isHidden = false
        fadeIn()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
    }
    
}
