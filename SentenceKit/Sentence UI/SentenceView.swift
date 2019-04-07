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
    
    var textView = UITextView(autolayout: true)
    var sentence: Sentence? {
        didSet {
            guard let sentence = sentence else { return }
            for c in sentence.components {
                if c.isInput,
                    var inputControl = c as? InputControl {
                    inputControl.delegate = self
                }
            }
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
        styleContext = StyleContext(font: UIFont.boldSystemFont(ofSize: 20),
                                       controlColor: UIColor.blue,
                                       textColor: UIColor.black,
                                       paragraphStyle:paragraphStyle)
        textView.isEditable = false
        textView.isSelectable = false
        textView.delegate = self
        addSubview(textView)
    }
    
    func frameOfTextRange(range:NSRange) -> CGRect {
        let beg = textView.beginningOfDocument
        
        guard let start = textView.position(from: beg, offset: range.location),
        let end = textView.position(from: start, offset: range.length),
        let textRange = textView.textRange(from: start, to: end) else { return CGRect.zero }
        
        return textView.firstRect(for: textRange)
    }
    
    // recursive
    
    func layoutComponents(){
        var nl = NSMutableIndexSet()
        layoutComponents(newLines: &nl)
        
    }
    func layoutComponents(newLines: inout NSMutableIndexSet) {
        
        guard let styleContext = self.styleContext,
        let sentence = self.sentence else {
            return
        }
    
        // variables
        let mutableAttString = NSMutableAttributedString()
        var counter = 0
        for component in sentence.components {
            
            var attString:NSMutableAttributedString
            
            // form sentence text
            var attributes = [NSAttributedString.Key : Any]()
            attributes[NSAttributedString.Key.font] = styleContext.font
            attributes[NSAttributedString.Key.foregroundColor] = component.isInput ? UIColor.clear : styleContext.textColor
            attributes[NSAttributedString.Key.paragraphStyle] = styleContext.paragraphStyle
            
            if component.isInput{
                guard let inputControl = component as? InputControl else {
                    return
                }
                attString = inputControl.attributedString(styleContext: styleContext)
                let wholeRange = NSRange(location: 0, length: attString.string.count)
                attString.setAttributes(attributes, range: wholeRange)
            }else{
                attString = NSMutableAttributedString(string: component.stringValue, attributes: attributes)
            }
            
            if newLines.contains(counter) {
                attString.append(NSAttributedString(string: "\n"))
            }
            
            mutableAttString.append(attString)
            counter += 1
        }
        
        // write text to text view
        self.textView.attributedText = mutableAttString
        self.textView.layoutManager.ensureLayout(for: self.textView.textContainer)
        self.textView.layoutSubviews()
        
        // create controls
        counter = 0
        
        let maxNewLine = newLines.max() ?? 0
        for component in sentence.components {
            
            var range:NSRange = NSRange()
            var rect:CGRect = CGRect.zero
            if (!component.isInput || counter < maxNewLine){
                
                counter += 1
                continue
            }
            
            guard var inputControl = component as? InputControl else {
                return
            }
            
            range = styleContext.showsArrow ? (self.textView.text as NSString).range(of: component.stringValue + arrow) : (self.textView.text as NSString).range(of: component.stringValue)
            rect = self.frameOfTextRange(range: range)
            
            // Remove line spacing from rect, save for last line
            // find last character y value
            let lastCharRange = NSRange(location: textView.text.count-1, length: 1)
            let lastCharRect = self.frameOfTextRange(range: lastCharRange)
            let lastCharY = lastCharRect.origin.y
                        
            let lineSpacing = paragraphStyle.lineSpacing
            if rect.origin.y < lastCharY {
                rect.size.height = rect.size.height - lineSpacing
            }
            
            let controlView = inputControl.view(styleContext: styleContext, frame: rect)
            
            // determine if rect is too long for textview
            if inputControl.tooWide(styleContext: styleContext, frame: rect) {
                print("\(component.stringValue) rect too big needs new line")
                if counter-1 >= 0 {
                    newLines.add(counter-1)
                    layoutComponents(newLines: &newLines)
                    return
                }else{
                    print("first component does not fit on screen")
                }
            }else{
                // debugging
                let v = UIView(frame: rect)
                v.backgroundColor = UIColor.green.opacity(0.2)
                self.textView.addSubview(v)
                self.textView.addSubview(controlView)
                inputControl.superview = self.textView
            }            
            counter += 1
        }
    }
    
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL, options: [:])
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
    }
}

extension SentenceView: InputControlDelegate {
    func showEditModal(control: InputControl) {
        delegate?.showEditModal(control: control)
    }
    
    func valueDidChange(control: InputControl, newValue: String) {
        delegate?.valueDidChange(control: control, newValue: newValue)
    }
    
    
}
