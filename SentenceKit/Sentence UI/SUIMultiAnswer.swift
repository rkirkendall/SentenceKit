//
//  SUIMultiAnswer.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/12/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import UIKit

class SUIMultiAnswer: SUIInputControl {
    
    weak var superview:UIView?
    var styleContext:SUIStyleContext?
    var options: [String] = [String]()
    var stringValue:String {
        return options.count > 0 ? options[0] : "    "
    }
    var isInput: Bool {
        return true
    }
    
    private var optionsShowing = false
    private var button: UIButton?
    private var optionsView: UIView?
    
    func tooWide(styleContext: SUIStyleContext, frame: CGRect) -> Bool {
        let button = view(styleContext: styleContext, frame: frame) as? UIButton
        return button?.titleIsTruncated ?? false
    }
    
    func attributedString(styleContext: SUIStyleContext) -> NSMutableAttributedString {
        self.styleContext = styleContext
        var attributes = [NSAttributedString.Key:Any]()
        attributes[NSAttributedString.Key.font] = styleContext.font
        attributes[NSAttributedString.Key.underlineStyle] =  NSUnderlineStyle.single.rawValue
        attributes[NSAttributedString.Key.foregroundColor] = styleContext.controlColor
        let attString = NSMutableAttributedString(string: stringValue, attributes: attributes)
        let arrowFontSize = CGFloat(styleContext.font.pointSize * 0.7)
        
        // construct arrow att string and append
        let blueArrowAtts = [NSAttributedString.Key.foregroundColor: styleContext.controlColor,
                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: arrowFontSize),
                             NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
        attString.append(NSAttributedString(string: arrow, attributes: blueArrowAtts))
        return attString
    }
    
    func view(styleContext: SUIStyleContext, frame: CGRect) -> UIView {
        let button = UIButton(frame: frame)
        let attButtonTitle = attributedString(styleContext: styleContext)
        button.setAttributedTitle(attButtonTitle, for: .normal)
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.button = button
        return button
    }
    
    @objc func buttonTapped(){
        toggleShowOptions()
    }
    
    func toggleShowOptions(){
        
        // todo: component should close all other UI open / edit states        
        // todo: find longest option and base size off that
        
        optionsShowing = !optionsShowing
        optionsView?.isHidden = !optionsShowing
        if optionsView != nil{
            return
        }
        
        guard let button = self.button,
            let styleContext = self.styleContext else {
                return
        }
        
        var optionsFrame = CGRect.zero
        optionsFrame.size.height = button.frame.height * CGFloat(options.count) + 10
        optionsFrame.size.width = button.frame.width
        optionsFrame.origin.y = button.frame.origin.y + button.frame.size.height
        optionsFrame.origin.x = button.frame.origin.x
        
        let view = UIView(frame: optionsFrame)
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        
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
            view.addSubview(optButton)
            count += 1
        }
        optionsView = view
        
        superview?.addSubview(view)
        
    }
}
