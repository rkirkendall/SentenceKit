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

extension UIButton {
    
    var titleIsTruncated: Bool {
        
        guard let labelText = titleLabel?.attributedText else {
            return false
        }
        print("label width: \(labelText.size().width)")
        print("frame width: \(frame.width)")
        return labelText.size().width > frame.width
    }
}

protocol SUIComponent {
    var stringValue: String {get}
    var isInput: Bool {get}
    // will extend
}

class SUIDropdown:SUIComponent {
    var options: [String] = [String]()
    var stringValue:String {
        return options.count > 0 ? options[0] : "    "
    }
    var isInput: Bool {
        return true
    }
}

extension String: SUIComponent {
    var stringValue: String {
        return self
    }
    var isInput: Bool {
        return false
    }
}

public class SUIView: ModernView, UITextViewDelegate {
    
    var components:[SUIComponent] = [SUIComponent]()
    var font = UIFont.boldSystemFont(ofSize: 35)
    var inputColor:UIColor = UIColor.blue
    var textColor:UIColor = UIColor.black
    
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
            attributes[NSAttributedString.Key.font] = self.font
            attributes[NSAttributedString.Key.foregroundColor] = component.isInput ? UIColor.clear : self.textColor
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
        //var newLinesNeededIx = -1
        counter = 0
        for component in self.components {
            
            if (!component.isInput){
                counter += 1
                continue
            }
            
            let range: NSRange = (self.textView.text as NSString).range(of: component.stringValue + arrow)
            let rect = self.frameOfTextRange(range: range)
            
            let v = UIView(frame: rect)
            v.backgroundColor = UIColor.green.opacity(0.2)
            self.textView.addSubview(v)
            
            let button = UIButton(frame: rect)
            var buttonAtts = self.textView.attributedText.attributes(at: 0, effectiveRange: nil)
            buttonAtts[NSAttributedString.Key.underlineStyle] =  (NSUnderlineStyle.single.rawValue | NSUnderlineStyle.patternDot.rawValue)
            buttonAtts[NSAttributedString.Key.foregroundColor] = UIColor.blue
            let attButtonTitle = NSMutableAttributedString(string: component.stringValue, attributes: buttonAtts)
            let arrowFontSize = CGFloat(self.font.pointSize * 0.5)
            // construct arrow att string and append
            let blueArrowAtts = [NSAttributedString.Key.foregroundColor: UIColor.blue,
                                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: arrowFontSize),
                                 NSAttributedString.Key.underlineStyle: (NSUnderlineStyle.single.rawValue | NSUnderlineStyle.patternDot.rawValue)] as [NSAttributedString.Key : Any]
            attButtonTitle.append(NSAttributedString(string: arrow, attributes: blueArrowAtts))

            button.setAttributedTitle(attButtonTitle, for: .normal)
            
            // determine if rect is too long for textview
            if button.titleIsTruncated{
                print("rect too big needs new line")
                if counter-1 >= 0 {
                    return layoutComponents(newLineNeeded: counter-1)
                }else{
                    print("first component does not fit on screen")
                }
            }
            self.textView.addSubview(button)
            counter += 1
        }
    }
    
    public override func setupView() {
        super.setupView()
        textView.isEditable = false
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
