//
//  SUIView.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/9/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import UIKit
import Modernistik

/*
 
 [
 "i feel like"
 _activityDropdown
 "with my"
 _peopleTextField
 ]
 
 var sentenceView = SentenceView()
 sentenceView += "I feel like"
 sentenceView += _activityDropdown
 sentenceView += "with my"
 sentenceView += _peopleTextField
 
 */

protocol SUIComponent {
    var stringValue: String {get}
    var isInput: Bool {get}
    var superview: UIView? {set get}
}

protocol SUIInputControl: SUIComponent {
    func tooWide(styleContext: SUIStyleContext, frame: CGRect) -> Bool
    func view(styleContext: SUIStyleContext, frame: CGRect) -> UIView
}; extension SUIInputControl {
    var isInput: Bool { return true }
    var arrow:String { return "▾"}
}

protocol SUIInputControlDelegate {
}

class SUIDropdown: SUIInputControl {

    var options: [String] = [String]()
    var stringValue:String {
        return options.count > 0 ? options[0] : "    "
    }
    var isInput: Bool {
        return true
    }
    
    private var dropdownOptionsShowing = false
    
    var styleContext:SUIStyleContext?
    private var button: UIButton?
    private var dropdown: UIView?
    weak var superview:UIView?

    func tooWide(styleContext: SUIStyleContext, frame: CGRect) -> Bool {
        let button = view(styleContext: styleContext, frame: frame) as? UIButton
        return button?.titleIsTruncated ?? false
    }
    
    func view(styleContext: SUIStyleContext, frame: CGRect) -> UIView {
        let button = UIButton(frame: frame)
        self.styleContext = styleContext
        var attributes = [NSAttributedString.Key:Any]()
        attributes[NSAttributedString.Key.font] = styleContext.font
        attributes[NSAttributedString.Key.underlineStyle] =  NSUnderlineStyle.single.rawValue
        attributes[NSAttributedString.Key.foregroundColor] = styleContext.controlColor
        let attButtonTitle = NSMutableAttributedString(string: stringValue, attributes: attributes)
        let arrowFontSize = CGFloat(styleContext.font.pointSize * 0.5)
        
        // construct arrow att string and append
        let blueArrowAtts = [NSAttributedString.Key.foregroundColor: styleContext.controlColor,
                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: arrowFontSize),
                             NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
        attButtonTitle.append(NSAttributedString(string: arrow, attributes: blueArrowAtts))
        
        button.setAttributedTitle(attButtonTitle, for: .normal)
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.button = button
        return button
    }
    
    @objc func buttonTapped(){
        print("hello there")
        toggleDropdown()
    }
    
    func toggleDropdown(){
        // todo: find longest option and base size off that
        
        dropdownOptionsShowing = !dropdownOptionsShowing
        dropdown?.isHidden = !dropdownOptionsShowing
        if dropdown != nil{
            return
        }
        
        guard let button = self.button,
        let styleContext = self.styleContext else {
            return
        }
        
        var dropdownFrame = CGRect.zero
        dropdownFrame.size.height = button.frame.height * CGFloat(options.count) + 10
        dropdownFrame.size.width = button.frame.width
        dropdownFrame.origin.y = button.frame.origin.y + button.frame.size.height
        dropdownFrame.origin.x = button.frame.origin.x
        
        let dropdownView = UIView(frame: dropdownFrame)
        dropdownView.backgroundColor = .white
        dropdownView.layer.borderWidth = 1
        
        var count = 0
        for opt in options {
            var atts = [NSAttributedString.Key:Any]()
            atts[NSAttributedString.Key.font] = styleContext.font
            atts[NSAttributedString.Key.foregroundColor] = styleContext.controlColor
            let optAttString = NSAttributedString(string: opt, attributes: atts)
            var rect = CGRect.zero
            rect.origin.x =  5 
            rect.origin.y = 0 + 5 + (CGFloat(count) * button.frame.height)
            rect.size = optAttString.size()
            let optButton = UIButton(frame: rect)
            optButton.setAttributedTitle(optAttString, for: .normal)
            dropdownView.addSubview(optButton)
            count += 1
        }
        self.dropdown = dropdownView
        
        superview?.addSubview(dropdownView)
        
    }
}

struct SUIStyleContext {
    let font: UIFont
    let controlColor: UIColor
    let textColor: UIColor
}

public class SUIView: ModernView, UITextViewDelegate {
    
    var components:[SUIComponent] = [SUIComponent]()
    let styleContext = SUIStyleContext(font: UIFont.boldSystemFont(ofSize: 35),
                                       controlColor: UIColor.blue,
                                       textColor: UIColor.black)
    
    static func += (left: SUIView, right: SUIComponent) {
        left.components.append(right)
        left.layoutComponents()
    }
    
    
    func frameOfTextRange(range:NSRange) -> CGRect {
        let beg = textView.beginningOfDocument
        let start = textView.position(from: beg, offset: range.location)
        let end = textView.position(from: start!, offset: range.length)
        let textRange = textView.textRange(from: start!, to: end!)
        return textView.firstRect(for: textRange!)
    }
    
    func layoutComponents(){
        layoutComponents(newLineNeeded: -1)
    }
    
    func layoutComponents(newLineNeeded:Int) {
    
        // variables
        let mutableAttString = NSMutableAttributedString()
        let arrow = "▾"
        var counter = 0
        for component in self.components {
            
            // form sentence text
            var attributes = [NSAttributedString.Key : Any]()
            attributes[NSAttributedString.Key.font] = styleContext.font
            attributes[NSAttributedString.Key.foregroundColor] = component.isInput ? UIColor.clear : styleContext.textColor
            var componentString:String = component.isInput ? component.stringValue + arrow : component.stringValue
            if counter == newLineNeeded {
                componentString += "\n"
            }
            let attString = NSAttributedString(string: componentString, attributes: attributes)
            mutableAttString.append(attString)
            counter += 1
        }
        
        // write text to text view
        self.textView.attributedText = mutableAttString
        self.textView.layoutManager.ensureLayout(for: self.textView.textContainer)
        self.textView.layoutSubviews()
        
        // create controls
        counter = 0
        for component in self.components {
            
            if (!component.isInput){
                counter += 1
                continue
            }
            
            guard var inputControl = component as? SUIInputControl else {
                return
            }
            
            let range: NSRange = (self.textView.text as NSString).range(of: component.stringValue + arrow)
            let rect = self.frameOfTextRange(range: range)
            
            let controlView = inputControl.view(styleContext: styleContext, frame: rect)
            
            // determine if rect is too long for textview
            if inputControl.tooWide(styleContext: styleContext, frame: rect) {
                print("rect too big needs new line")
                if counter-1 >= 0 {
                    return layoutComponents(newLineNeeded: counter-1)
                }else{
                    print("first component does not fit on screen")
                }
            }
            self.textView.addSubview(controlView)
            inputControl.superview = self.textView
            counter += 1
        }
    }
    
    public override func setupView() {
        super.setupView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.delegate = self
        //textView.font = font
        addSubview(textView)
    }
    
    var textView = UITextView(autolayout: true)
    
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
