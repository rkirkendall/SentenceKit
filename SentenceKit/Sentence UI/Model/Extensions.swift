//
//  Extensions.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/10/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation

extension String: Fragmentable {
    
    var stringValue: String {
        return self
    }
    
    func attributedString(styleContext: Style) -> NSMutableAttributedString {
        return Fragment.attributedString(string: self, styleContext: styleContext)
    }
    
}
