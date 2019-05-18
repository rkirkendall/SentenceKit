//
//  View.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/9/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import UIKit
import Modernistik

public class SentenceView: ModernView, UITextViewDelegate {
    
    var textView = SentenceTextView(autolayout: true)
    weak var delegate: ControlFragmentDelegate?
    
    var sentence: Sentence? {
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
    
    var style: Style? {
        didSet {
            updateInterface()
        }
    }
    
    public override func setupView() {
        super.setupView()
        textView.backgroundColor = .clear
        // todo: line spacing should be a function of font size
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 20
        paragraphStyle.alignment = .center
        if style.isNil {
            style = Style(font: UIFont.boldSystemFont(ofSize: 40),
                                        controlColor: .blue,
                                        textColor: .black,
                                        underlineColor: .blue,
                                        backgroundColor: .clear,
                                        paragraphStyle:paragraphStyle,
                                        kern: nil)
        }
        
        textView.isEditable = false
        textView.delegate = self
        
        addSubview(textView)
    }
    
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {

        let hashInt = Int(URL.absoluteString)
        guard let hash = hashInt,
            let controlFragment = sentence?.fragmentMap[hash] else { return false }
        controlFragmentWillShowEditController(controlFragment)        
        return false
    }
    
    public override func setupConstraints() {
        super.setupConstraints()
        let views = ["textView":textView]
        var constraints = [NSLayoutConstraint]()
        constraints += "V:|-[textView]-|".constraints(views: views)
        constraints += "H:|-[textView]-|".constraints(views: views)
        addConstraints(constraints)
    }
    
    public override func updateInterface() {
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

extension SentenceView: ControlFragmentDelegate {
    
    func controlFragmentWillShowEditController(_ controlFragment: ControlFragment) {
        delegate?.controlFragmentWillShowEditController(controlFragment)
    }
    
    func controlFragment(_ controlFragment: ControlFragment, stringDidChange string: String) {
        updateInterface()
        delegate?.controlFragment(controlFragment, stringDidChange: string)
    }
    
}
