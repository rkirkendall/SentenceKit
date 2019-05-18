//
//  Fragment.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/12/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation

protocol Fragmentable {
    var string: String { get set }
    func attributedString(style: Style) -> NSMutableAttributedString
}

open class Fragment: NSObject, Fragmentable {
    var alias: String?
    var string: String = "" {
        didSet {
            alias = string
        }
    }
    
    func attributedString(style: Style) -> NSMutableAttributedString {
        return Fragment.attributedString(string: (alias ?? string), style: style)
    }
    
    static func attributedString(string: String, style: Style) -> NSMutableAttributedString {
        var atts = [NSMutableAttributedString.Key:Any]()
        var mutableString = string
        if !style.font.isNil { atts[NSMutableAttributedString.Key.font] = style.font }
        if !style.textColor.isNil { atts[NSMutableAttributedString.Key.foregroundColor] = style.textColor }
        if !style.paragraphStyle.isNil { atts[NSMutableAttributedString.Key.paragraphStyle] = style.paragraphStyle }
        if !style.kern.isNil { atts[NSMutableAttributedString.Key.kern] = style.kern }
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

protocol ControlFragmentDelegate: class {
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
    
    override func attributedString(style: Style) -> NSMutableAttributedString {
        let superString = super.attributedString(style: style)
        superString.addAttribute(NSAttributedString.Key.link, value: String(hashValue), range: NSRange(location: 0, length: superString.string.count))
        return superString
    }
}

let arrow:String = "⌄"
