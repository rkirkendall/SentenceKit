//
//  SEKTextView.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 2/18/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import UIKit
import Modernistik

public class SEKTextView: ModernView, UITextViewDelegate {
    
    var textView = UITextView(autolayout: true)
    
    public override func setupView() {
        super.setupView()
        
        let font = UIFont.boldSystemFont(ofSize: 35)
        
        let feelLike = "I feel like " //.attributes(atts)
        let feelLikeAS = NSAttributedString(string: feelLike, attributes: [NSAttributedString.Key.font: font])
        
        let withBoysAS = NSAttributedString(string: " with my boys.", attributes: [NSAttributedString.Key.font: font])
        
        // button element has a clear color, but has the same font
        // add space on to button element to allow for drop down arrow
        let partying = "`partying hard`"
        let partyingAtts = [NSAttributedString.Key.foregroundColor: UIColor.red,
                            NSAttributedString.Key.font: font] as [NSAttributedString.Key : Any]
        let partyingAS = NSAttributedString(string: partying, attributes: [:])
        
        let arrow = "▾"
        let arrowAtts = [NSAttributedString.Key.foregroundColor: UIColor.clear,
                         NSAttributedString.Key.font: font]
        let arrowAS = NSAttributedString(string: arrow, attributes: arrowAtts)
        
        
        formatInteractiveTextWithAttributes(attributes: partyingAtts)
        
        // final string setup
        let final = NSMutableAttributedString()
        final.append(feelLikeAS)
        final.append(partyingAS)
        final.append(arrowAS)
        final.append(withBoysAS)
        textView.attributedText = final
        
        textView.isEditable = false
        textView.delegate = self        
        addSubview(textView)
    }
    
    public func formatInteractiveTextWithAttributes(attributes:[NSAttributedString.Key: Any]){
        var theString = textView.attributedText.string
        let regex = try? NSRegularExpression(pattern: "`.+?`", options:[])
        guard let matchesArray = regex?.matches(in: theString, options: [], range: NSMakeRange(0, theString.count)) else {
            print("matchesArray nil")
            return
        }
        
        guard let theAttributedString = textView.attributedText.mutableCopy() as? NSMutableAttributedString else{
            print("the attributedString is nil")
            return
        }
        
        for match in matchesArray {
            let range = match.range
            if(range.location != NSNotFound){
                theAttributedString.addAttributes(attributes, range: range)
            }
        }
        
        textView.attributedText = theAttributedString
        
        for match in matchesArray {
            let range = match.range
            if(range.location != NSNotFound){
                let selectRect = frameOfTextRange(range: range)
                let styleView = UIView(frame: selectRect)
                styleView.backgroundColor = .green
                textView.insertSubview(styleView, at: 0)
            }
        }
    }
    
    
    public func frameOfTextRange(range: NSRange) -> CGRect{
        self.textView.selectedRange = range
        guard let textRange = self.textView.selectedTextRange else{
            return CGRect.zero
        }
        let rect = self.textView.firstRect(for: textRange)
        return rect
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

