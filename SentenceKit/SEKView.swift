//
//  SEKView.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 2/18/19.
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

public class SEKView: ModernView, UITextViewDelegate {
    
    var textView = UITextView(autolayout: true)
    
    public override func setupView() {
        super.setupView()
        let font = UIFont.boldSystemFont(ofSize: 35)
        
        let feelLike = "I feel like\n" //.attributes(atts)
        let feelLikeAS = NSAttributedString(string: feelLike, attributes: [NSAttributedString.Key.font: font])
        
        let withBoysAS = NSAttributedString(string: "\nwith my boys.", attributes: [NSAttributedString.Key.font: font])
        
        // button element has a clear color, but has the same font
        // add space on to button element to allow for drop down arrow
        let partying = "partying"
        let partyingAtts = [NSAttributedString.Key.foregroundColor: UIColor.clear,
                            NSAttributedString.Key.font: font] as [NSAttributedString.Key : Any]
        let partyingAS = NSAttributedString(string: partying, attributes: partyingAtts)
        
        let arrow = "▾"
        let arrowAtts = [NSAttributedString.Key.foregroundColor: UIColor.clear,
                         NSAttributedString.Key.font: font]
        let arrowAS = NSAttributedString(string: arrow, attributes: arrowAtts)
        
        // final string setup
        let final = NSMutableAttributedString()
        final.append(feelLikeAS)
        final.append(partyingAS)
        final.append(arrowAS)
        final.append(withBoysAS)
        textView.attributedText = final
        
        // get size and loc of the button element
        let range: NSRange = (textView.text as NSString).range(of: partying+arrow)
        let beginning: UITextPosition? = textView.beginningOfDocument
        let start: UITextPosition? = textView.position(from: beginning!, offset: range.location)
        let end: UITextPosition? = textView.position(from: start!, offset: range.length)
        let textRange: UITextRange? = textView.textRange(from: start!, to: end!)
        
        let firstRect = textView.firstRect(for: textRange!)
        let button = UIButton(frame: firstRect)
        var buttonAtts = partyingAS.attributes(at: 0, effectiveRange: nil)
        buttonAtts[NSAttributedString.Key.underlineStyle] =  (NSUnderlineStyle.single.rawValue | NSUnderlineStyle.patternDot.rawValue)
        buttonAtts[NSAttributedString.Key.foregroundColor] = UIColor.blue
        let attButtonTitle = NSMutableAttributedString(string: partying, attributes: buttonAtts)
        let arrowFontSize = CGFloat(font.pointSize * 0.5)
        // construct arrow att string and append
        let blueArrowAtts = [NSAttributedString.Key.foregroundColor: UIColor.blue,
                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: arrowFontSize),
                             NSAttributedString.Key.underlineStyle: (NSUnderlineStyle.single.rawValue | NSUnderlineStyle.patternDot.rawValue)] as [NSAttributedString.Key : Any]
        attButtonTitle.append(NSAttributedString(string: arrow, attributes: blueArrowAtts))

        button.setAttributedTitle(attButtonTitle, for: .normal)
        textView.addSubview(button)
        
        textView.isEditable = false
        textView.delegate = self
        addSubview(textView)
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
