//
//  Component.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/12/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import UIKit

class Sentence {
    var fragments:[Fragmentable] = [Fragmentable]()
    var fragmentMap = [Int: ControlFragment]()
    var resolutions = Resolutions()
    
    func resolve() {
        for r in resolutions {
            r()
        }
    }
    
    func appendFragment(_ fragment: Fragmentable) {
        fragments.append(fragment)
        if fragment is ControlFragment {
            guard let controlFragment = fragment as? ControlFragment else { return }
            fragmentMap[controlFragment.hashValue] = controlFragment
        }
    }
    static func += (left: Sentence, right: Fragmentable) {
        left.appendFragment(right)
    }
}

struct StyleContext {
    let font: UIFont?
    let controlColor: UIColor?
    let textColor: UIColor?
    let paragraphStyle: NSParagraphStyle?
}

protocol Fragmentable {
    var stringValue: String { get }
    func attributedString(styleContext: StyleContext) -> NSMutableAttributedString
}

class Fragment: NSObject, Fragmentable {
    var stringValue: String = ""
    
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

protocol InputControlDelegate: class {
    func showEditModal(control: ControlFragment)
    func valueDidChange(control: ControlFragment, newValue: String)
}

class ControlFragment: Fragment {
    weak var delegate: InputControlDelegate?
    var editView: EditBaseController?
    
    override func attributedString(styleContext: StyleContext) -> NSMutableAttributedString {
        let superString = super.attributedString(styleContext: styleContext)
        superString.addAttribute(NSAttributedString.Key.link, value: String(hashValue), range: NSRange(location: 0, length: superString.string.count))
        return superString
    }
}

let arrow:String = "⌄"
