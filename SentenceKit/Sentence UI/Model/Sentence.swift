//
//  Sentence.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 4/28/19.
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
    let underlineColor: UIColor?
    let paragraphStyle: NSParagraphStyle?
}