//
//  Sentence.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 4/28/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import UIKit

/// The main model object in Sentence UI's. Contains all sentence fragments and resolutions for fragment dependencies.
class Sentence {
    
    internal var fragmentMap = [Int: ControlFragment]()
    
    /// Compositional fragments
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
    /// `sentence.resolutions += { if self.iceChoice.alias == "None" { self.iceChoice.alias = "No" } }`
    public var resolutions = Resolutions()
    
    public var dictionary: [String: Any] {
        
        var dict = [String: Any]()
        for f in fragmentMap.values {
            dict[f.tag] = f.string
        }
        
        return dict
    }
    
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

struct Style {
    
    enum TextCase {
        case upper
        case lower
    }
    
    let font: UIFont?
    let controlColor: UIColor?
    let textColor: UIColor?
    let underlineColor: UIColor?
    let backgroundColor: UIColor?
    let paragraphStyle: NSParagraphStyle?
    let kern: Double?
    let textCase: TextCase?
}
