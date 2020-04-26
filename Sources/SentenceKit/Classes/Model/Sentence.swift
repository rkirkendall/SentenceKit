//
//  Sentence.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 4/28/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit


/// The main model object in Sentence UI's. Contains all sentence fragments and resolutions for fragment dependencies.
public class Sentence {
    
    internal var fragmentMap = [Int: ControlFragment]()
    
    /// Fragments are words and phrases that are concatenated together to form a sentence.
    public var fragments: [Fragmentable] = [Fragmentable]()    
    
    /// Resolutions to fragment dependencies
    ///
    /// Resolutions should be thought of as steps taken after the sentence has been composed from fragments.
    /// A common use for resolutions is to "clean up" the sentence after a combination of fragment values render
    /// the sentence gramatically incorrect or nonsensical. This can be done conditionally setting fragments' alias
    /// value.
    ///
    /// `Resolutions` supports `+=` for appending `Resolution` blocks.
    ///
    /// For example, consider changing the ice descriptor in the following sentence from `crushed` to `none`:
    ///
    /// "I would like a mojito with __crushed__ ice."
    ///
    /// The following resolution could be used to alias `none` to `no` so the choice makes sense within the sentence.
    ///
    /// `sentence.resolutions += { if self.iceChoice.alias == "None" { self.iceChoice.alias = "no" } }`
    public var resolutions = Resolutions()
    
    
    /// Dictionary of control tags mapped to user-set values
    open var dictionary: [String: Any] {
        
        var dict = [String: Any]()
        for f in fragmentMap.values {
            dict[f.tag] = f.string
        }
        
        return dict
    }
    
    internal func resolve() {
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
    public static func += (left: Sentence, right: Fragmentable) {
        left.appendFragment(right)
    }
}

public class SentenceStyle {
    
    public enum TextCase {
        case upper
        case lower
    }
    
    public init(font:UIFont,
         controlColor:UIColor?,
         textColor: UIColor,
         underlineColor: UIColor?,
         backgroundColor: UIColor?,
         paragraphStyle: NSParagraphStyle?,
         kern: Double?,
         textCase: TextCase?) {
        self.font = font
        self.controlColor = controlColor
        self.underlineColor = underlineColor
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.paragraphStyle = paragraphStyle
        self.kern = kern
        self.textCase = textCase
    }
    
    public var font: UIFont? = nil
    public var controlColor: UIColor?
    public var textColor: UIColor?
    public var underlineColor: UIColor?
    public var backgroundColor: UIColor?
    public var paragraphStyle: NSParagraphStyle?
    public var kern: Double?
    public var textCase: TextCase?
}

#endif
