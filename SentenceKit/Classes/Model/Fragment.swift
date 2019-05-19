//
//  Fragment.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/12/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation

public protocol Fragmentable {
    var string: String { get set }
    func attributedString(style: Style) -> NSMutableAttributedString
}

open class Fragment: NSObject, Fragmentable {
    open var alias: String?
    open var string: String = "" {
        didSet {
            alias = string
        }
    }
    
    open func attributedString(style: Style) -> NSMutableAttributedString {
        return Fragment.attributedString(string: (alias ?? string), style: style)
    }
    
    internal static func attributedString(string: String, style: Style) -> NSMutableAttributedString {
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
    var placeholder = "..."
    var tag: String
    
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
    
    override open func attributedString(style: Style) -> NSMutableAttributedString {
        let superString = super.attributedString(style: style)
        superString.addAttribute(NSAttributedString.Key.link, value: String(hashValue), range: NSRange(location: 0, length: superString.string.count))
        return superString
    }
}

let arrow:String = "⌄"
