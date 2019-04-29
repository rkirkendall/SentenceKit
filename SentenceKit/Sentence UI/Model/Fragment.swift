//
//  Fragment.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/12/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation

protocol Fragmentable {
    var stringValue: String { get }
    func attributedString(styleContext: StyleContext) -> NSMutableAttributedString
}

class Fragment: NSObject, Fragmentable {
    var stringValue: String = ""
    var styleContext: StyleContext?
    func attributedString(styleContext: StyleContext) -> NSMutableAttributedString {
        return Fragment.attributedString(string: stringValue, styleContext: styleContext)
    }
    
    static func attributedString(string:String, styleContext: StyleContext) -> NSMutableAttributedString {
        var atts = [NSMutableAttributedString.Key:Any]()
        
        atts[NSMutableAttributedString.Key.font] = styleContext.font
        atts[NSMutableAttributedString.Key.foregroundColor] = styleContext.textColor
        atts[NSMutableAttributedString.Key.paragraphStyle] = styleContext.paragraphStyle
        
        return NSMutableAttributedString(string: string, attributes: atts)
    }
}

protocol ControlFragmentDelegate: class {
    func showEditModal(control: ControlFragment)
    func valueDidChange(control: ControlFragment, newValue: String)
}

class ControlFragment: Fragment {
    weak var delegate: ControlFragmentDelegate?
    var editView: EditBaseController?
    let emptyPlaceholder = "      "
    var identifier: String
    
    convenience init(_ identifier: String) {
        self.init(identifier: identifier)
    }
    
    init(identifier: String) {
        self.identifier = identifier
        super.init()
    }
    
    override init() {
        identifier = ""
        super.init()
    }
    
    
    override func attributedString(styleContext: StyleContext) -> NSMutableAttributedString {
        let superString = super.attributedString(styleContext: styleContext)
        superString.addAttribute(NSAttributedString.Key.link, value: String(hashValue), range: NSRange(location: 0, length: superString.string.count))
        return superString
    }
}

let arrow:String = "⌄"
