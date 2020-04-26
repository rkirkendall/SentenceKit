//
//  Fragment.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/12/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
public protocol Fragmentable {
    var string: String { get set }
    func attributedString(style: SentenceStyle) -> NSMutableAttributedString
}

open class Fragment: NSObject, Fragmentable {
    open var alias: String?
    open var string: String = "" {
        didSet { alias = string }
    }
    
    open func attributedString(style: SentenceStyle) -> NSMutableAttributedString {
        return Fragment.attributedString(string: (alias ?? string), style: style)
    }
    
    internal static func attributedString(string: String, style: SentenceStyle) -> NSMutableAttributedString {
        var atts = [NSMutableAttributedString.Key:Any]()
        var mutableString = string        
        if style.font != nil { atts[NSMutableAttributedString.Key.font] = style.font }
        if style.textColor != nil { atts[NSMutableAttributedString.Key.foregroundColor] = style.textColor }
        if style.paragraphStyle != nil { atts[NSMutableAttributedString.Key.paragraphStyle] = style.paragraphStyle }
        if style.kern != nil { atts[NSMutableAttributedString.Key.kern] = style.kern }
        if let textCase = style.textCase {
            switch textCase {
            case .upper:
                mutableString = string.uppercased()
            case .lower:
                mutableString = string.lowercased()
            }
        }
        
        return NSMutableAttributedString(string: mutableString, attributes: atts)
    }
}

public protocol ControlFragmentDelegate: class {
    func controlFragmentWillShowEditController(_ controlFragment: ControlFragment)
    func controlFragment(_ controlFragment: ControlFragment, stringDidChange string: String)
}

open class ControlFragment: Fragment {
    weak var delegate: ControlFragmentDelegate?
    var editView: EditBaseController?
    public var placeholder = "..."
    public var tag: String
    public var hasInput = false
    public var disabled = false
    
    open override var string: String {
        get { return super.string }
        set {
            super.string = newValue
            delegate?.controlFragment(self, stringDidChange: newValue)
        }
    }
    
    required convenience public init(_ tag: String) {
        self.init(tag: tag)
    }
    
    required public init(tag: String) {
        self.tag = tag
        super.init()
    }
    
    override init() {
        tag = ""
        super.init()
    }
    
    override open func attributedString(style: SentenceStyle) -> NSMutableAttributedString {
        let superString = super.attributedString(style: style)
        
        if !hasInput && alias == placeholder {
            // slight transparency to show it is a placeholder
            var r = NSRange(location: 0, length: superString.length)
            var atts = superString.attributes(at: 0, effectiveRange: &r)
            var colorWithOpacity = superString.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: &r) as! UIColor
            colorWithOpacity = colorWithOpacity.withAlphaComponent(0.6)
            atts[NSAttributedString.Key.foregroundColor] = colorWithOpacity
            superString.setAttributes(atts, range: NSRange(location: 0, length: superString.length))
        }
        
        superString.addAttribute(NSAttributedString.Key.link, value: String(hashValue), range: NSRange(location: 0, length: superString.length))
        return superString
    }
}

let arrow:String = "⌄"
#endif
