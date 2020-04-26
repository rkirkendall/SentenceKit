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
    var dictionary: [String: Any] {
        
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
    let font: UIFont?
    let controlColor: UIColor?
    let textColor: UIColor?
    let underlineColor: UIColor?
    let backgroundColor: UIColor?
    let paragraphStyle: NSParagraphStyle?
}
