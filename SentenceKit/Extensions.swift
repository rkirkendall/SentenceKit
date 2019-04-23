//
//  Extensions.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/10/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    var titleIsTruncated: Bool {
        
        guard let labelText = titleLabel?.attributedText else {
            return false
        }
        //print("label width: \(labelText.size().width)")
        //print("frame width: \(frame.width)")
        return labelText.size().width > frame.width
    }
}

extension String: Fragmentable {
    
    var stringValue: String {
        return self
    }
    
    func attributedString(styleContext: StyleContext) -> NSMutableAttributedString {
        return Fragment.attributedString(string: self, styleContext: styleContext)
    }
    
}
