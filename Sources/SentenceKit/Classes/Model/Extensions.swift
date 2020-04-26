//
//  Extensions.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/10/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
#if canImport(UIKit)
extension String: Fragmentable {
    public var string: String {
        get { return self }
        set { self = newValue }
    }        
    
    public func attributedString(style: SentenceStyle) -> NSMutableAttributedString {
        return Fragment.attributedString(string: self, style: style)
    }
    
}
#endif   
