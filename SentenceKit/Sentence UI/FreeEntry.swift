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
        return UIView()
    }
    
}
