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

class SentenceTextView: UITextView {
    var sentenceComponents = [UIView]()
    
    func addSentenceComponentView(view: UIView) {
        sentenceComponents.append(view)
        addSubview(view)
    }
    
    func clearSentenceViews(){
        for c in sentenceComponents {
            c.removeFromSuperview()
        }
    }
}

public class SentenceView: ModernView, UITextViewDelegate {
    
    var textView = SentenceTextView(autolayout: true)
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
    
    func framesOfTextRange(range: NSRange) -> [CGRect] {
        let beg = textView.beginningOfDocument
        
        guard let start = textView.position(from: beg, offset: range.location),
            let end = textView.position(from: start, offset: range.length),
            let textRange = textView.textRange(from: start, to: end) else { return [CGRect.zero] }
        
        let ranges = textView.selectionRects(for: textRange)
//        for r in ranges{
//            print("possible range: \(r.debugDescription)")
//        }
        
        let toReturn = textView.selectionRects(for: textRange).map { $0.rect }
        //toReturn.size.width += 2 // padding
        
        return toReturn
    }
    
    func frameOfTextRange(range:NSRange) -> CGRect {
        return framesOfTextRange(range: range).first ?? CGRect.zero
    }
    
    // experimental: what if we replaced spaces with "_" to keep the text components from being broken up
    // across lines. if possible, this would prevent the logic needed to introduce line breaks
    
    func layoutComponentsSimple() {
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
            attributes[NSAttributedString.Key.foregroundColor] = component.isInput ? UIColor.blue : styleContext.textColor
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
            
            mutableAttString.append(attString)
            counter += 1
        }
        
        
        
    }
    
    // recursive
    
    func layoutComponents(){
        self.textView.clearSentenceViews()
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
            attributes[NSAttributedString.Key.foregroundColor] = component.isInput ? UIColor.blue : styleContext.textColor
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
        //return
        // create controls
        counter = 0
        
        let maxNewLine = newLines.max() ?? 0
        for component in sentence.components {
            
            var range:NSRange = NSRange()
            var rect:CGRect = CGRect.zero
            if (!component.isInput || counter < maxNewLine){
                print("skipping \(component.stringValue)")
                counter += 1
                continue
            }
            
            guard var inputControl = component as? InputControl else {
                return
            }
            print(inputControl.stringValue)
            let cursorIx = self.textView.text.index(self.textView.text.startIndex, offsetBy: maxNewLine)
            let remainingText = self.textView.text[cursorIx...]
            
            range = styleContext.showsArrow ? (remainingText as NSString).range(of: component.stringValue + arrow) : (remainingText as NSString).range(of: component.stringValue)
            rect = self.frameOfTextRange(range: range)
            
            
            
            // todo: need to account for the "creamy cream" case:
            // frameOfTextRange for "cream" will always return the first
            // part of creamy, causing a collision
            // solution is to keep track of component rects
            // return all rects for range
            // check to see if first one is used, go to next, etc
            
            
            
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
                    return layoutComponents(newLines: &newLines)
                    //return
                }else{
                    print("first component does not fit on screen")
                }
            }else{
                // debugging
                //let v = UIView(frame: rect)
                //v.backgroundColor = UIColor.green.opacity(0.2)
                //self.textView.addSentenceComponentView(view: v)
                self.textView.addSentenceComponentView(view: controlView)
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
