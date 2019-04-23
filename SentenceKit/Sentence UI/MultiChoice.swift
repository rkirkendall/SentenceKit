//
//  MultiChoice.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/12/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import UIKit

class MultiChoice: ControlFragment {
    
    var styleContext: StyleContext?
    var options: [String] = [String]()
    private var _editViewController = MultiChoiceEditViewController()
    private var _stringValue: String?
    override var stringValue: String {
        set {
            self._stringValue = newValue
        }
        get {
            if let s = _stringValue { return s }
            return options.count > 0 ? options[0] : "      "
        }
    }
    
    private var optionsShowing = false
    private var button: UIButton?
    private var optionsView: UIView?
    private var optionsTableView: UITableView?
    
    override init() {
        super.init()
        _editViewController.choices = options
        _editViewController.delegate = self
        editView = _editViewController
    }
    
//    func attributedString(styleContext: StyleContext) -> NSMutableAttributedString {
//        self.styleContext = styleContext
//        var attributes = [NSAttributedString.Key:Any]()
//        attributes[NSAttributedString.Key.font] = styleContext.font
//        attributes[NSAttributedString.Key.underlineStyle] =  NSUnderlineStyle.single.rawValue
//        attributes[NSAttributedString.Key.foregroundColor] = styleContext.controlColor
//        let attString = NSMutableAttributedString(string: stringValue, attributes: attributes)
//        // construct arrow att string and append
//
//        return attString
//    }
}

extension MultiChoice: EditVariableTextDelegate {
    func stringValueDidChange(newStringValue: String) {
        _stringValue = newStringValue        
        delegate?.valueDidChange(control: self, newValue: newStringValue)
    }
    
    
}
