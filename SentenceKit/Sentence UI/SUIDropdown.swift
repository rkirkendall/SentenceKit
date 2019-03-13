//
//  SUIDropdown.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/12/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import UIKit

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
        
        // todo: component should close all other UI open / edit states
        
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
