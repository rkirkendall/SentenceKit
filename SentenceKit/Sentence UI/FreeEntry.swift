//
//  FreeEntry.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/26/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import UIKit

class FreeEntry: InputControl {
    var editView: EditBaseController { get{
        return EditBaseController()
        }}
    
    weak var delegate: InputControlDelegate?
    
    var stringValue = ""
    var styleContext:StyleContext?
    var superview: UIView?
    var textField = UITextField()
    var backgroundLabel = UILabel()
    let placeholderString = "          "
    
    func tooWide(styleContext: StyleContext, frame: CGRect) -> Bool {
        return false
    }
    
    func attributedString(styleContext: StyleContext) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: "")
    }
    
    func view(styleContext: StyleContext, frame: CGRect) -> UIView {
        textField.frame = frame
        textField.addSubview(backgroundLabel)
        backgroundLabel.frame = CGRect(origin: CGPoint.zero, size: textField.frame.size)
        
        return UIView()
    }
    
//    view.addSubview(textField)
//    textField.addSubview(label)
//    textField.frame = CGRect(x: 10, y: 400, width: 300, height: 50)
//    textField.backgroundColor = .lightGray
//    label.frame = CGRect(origin: CGPoint.zero, size: textField.frame.size)
//    label.text = "Test label"
    
}
