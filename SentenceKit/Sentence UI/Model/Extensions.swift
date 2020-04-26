//
//  Extensions.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/10/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation

extension String: Fragmentable {
    
    var string: String {
        get { return self }
        set { self = newValue }
    }
    
    func attributedString(style: Style) -> NSMutableAttributedString {
        return Fragment.attributedString(string: self, style: style)
    }
    
}
