//
//  View.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/9/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit


open class SentenceView: BaseView {
    
    private var textView = SentenceTextView(autolayout: true)
    open weak var delegate: ControlFragmentDelegate?
    
    open var sentence: Sentence? {
        didSet {
            guard let sentence = sentence else { return }
            for c in sentence.fragments {
                if c is ControlFragment,
                    let inputControl = c as? ControlFragment {
                    inputControl.delegate = self
                }
            }
            updateInterface()
        }
    }
    
    open var style: SentenceStyle? {
        didSet {
            updateInterface()
        }
    }
    
    open override func setupView() {
        super.setupView()
        textView.backgroundColor = .clear
        // todo: line spacing should be a function of font size
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 20
        paragraphStyle.alignment = .center
        if style == nil {
            style = SentenceStyle(font: UIFont.boldSystemFont(ofSize: 40),
                                        controlColor: .blue,
                                        textColor: .black,
                                        underlineColor: .blue,
                                        backgroundColor: .clear,
                                        paragraphStyle:paragraphStyle,
                                        kern: nil,
                                        textCase: nil)
        }
        
        textView.isEditable = false
        textView.delegate = self
        
        addSubview(textView)
    }
    
    open override func setupConstraints() {
        super.setupConstraints()
        let views = ["textView":textView]
        var constraints = [NSLayoutConstraint]()
        constraints += "V:|-[textView]-|".constraints(views: views)
        constraints += "H:|-[textView]-|".constraints(views: views)
        addConstraints(constraints)
    }
    
    open override func updateInterface() {
        super.updateInterface()
        guard let sentence = sentence,
            let style = style else { return }
        
        textView.text = ""
        sentence.resolve()
        let attributedString = NSMutableAttributedString(string: "")
        for fragment in sentence.fragments {
            attributedString.append(fragment.attributedString(style: style))
        }
        textView.attributedText = attributedString
        
        var linkAtts = [NSAttributedString.Key: Any]()
        linkAtts[NSAttributedString.Key.foregroundColor] = style.controlColor
        linkAtts[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue
        linkAtts[NSMutableAttributedString.Key.underlineColor] = style.underlineColor
        textView.linkTextAttributes = linkAtts
        
    }
}

extension SentenceView: UITextViewDelegate {
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        let hashInt = Int(URL.absoluteString)
        guard let hash = hashInt,
            let controlFragment = sentence?.fragmentMap[hash] else { return false }
        if controlFragment.disabled { return false }
        controlFragmentWillShowEditController(controlFragment)
        return false
    }
}

extension SentenceView: ControlFragmentDelegate {
    
    open func controlFragmentWillShowEditController(_ controlFragment: ControlFragment) {
        delegate?.controlFragmentWillShowEditController(controlFragment)
    }
    
    open func controlFragment(_ controlFragment: ControlFragment, stringDidChange string: String) {
        updateInterface()        
        delegate?.controlFragment(controlFragment, stringDidChange: string)
    }
    
}
#endif
