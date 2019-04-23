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

class SentenceTextView: UITextView {}

public class SentenceView: ModernView, UITextViewDelegate {
    
    var textView = SentenceTextView(autolayout: true)
    var sentence: Sentence? {
        didSet {
            guard let sentence = sentence else { return }
            for c in sentence.components {
                if c is ControlFragment,
                    let inputControl = c as? ControlFragment {
                    inputControl.delegate = self
                }
            }
            updateInterface()
        }
    }
    weak var delegate: InputControlDelegate?
    
    // todo: by default the font should autosize based the view's frame
    let paragraphStyle = NSMutableParagraphStyle()
    var styleContext: StyleContext?
    
    public override func setupView() {
        super.setupView()
        textView.backgroundColor = .clear
        // todo: line spacing should be a function of font size
        paragraphStyle.lineSpacing = 20
        if styleContext.isNil {
            styleContext = StyleContext(font: UIFont.boldSystemFont(ofSize: 50),
                                        controlColor: UIColor.blue,
                                        textColor: UIColor.black,
                                        paragraphStyle:paragraphStyle)
        }
        
        textView.isEditable = false
        textView.isSelectable = false
        textView.delegate = self
        
        var linkAtts = [NSAttributedString.Key: Any]()
        linkAtts[NSAttributedString.Key.foregroundColor] = styleContext?.controlColor
        linkAtts[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue
        textView.linkTextAttributes = linkAtts
        
        addSubview(textView)
    }
    
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
//        UIApplication.shared.open(URL, options: [:])
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
            let styleContext = styleContext else { return }
        
        textView.text = ""
        let attributedString = NSMutableAttributedString(string: "")
        for fragment in sentence.components {
            attributedString.append(fragment.attributedString(styleContext: styleContext))
        }
        textView.attributedText = attributedString
    }
}

extension SentenceView: InputControlDelegate {
    func showEditModal(control: ControlFragment) {
        delegate?.showEditModal(control: control)
    }
    
    func valueDidChange(control: ControlFragment, newValue: String) {
        delegate?.valueDidChange(control: control, newValue: newValue)
    }
    
    
}
